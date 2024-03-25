Extension { #name : #TEntityMetaLevelDependency }

{ #category : #'*Famix-Diff-Core' }
TEntityMetaLevelDependency >> compareParentsWith: otherEntity givenChanges: changes [

	<famixDiffIdentity>
	| baseParents targetParents |
	baseParents := self parents.
	targetParents := otherEntity parents.

	baseParents size = targetParents size ifFalse: [ ^ false ].

	baseParents do: [ :baseParent | 
		targetParents
			detect: [ :targetParent | self isParent: baseParent equivalentTo: targetParent givenChanges: changes ]
			ifNone: [ ^ false "A parent of the base entity does not have a matching parent so we escape." ] ].

	^ true
]

{ #category : #'*Famix-Diff-Core' }
TEntityMetaLevelDependency >> identityMatch: otherEntity givenChanges: changes [

	self class = otherEntity class ifFalse: [ ^ false ].

	(Pragma allNamed: #famixDiffIdentity from: self class to: ProtoObject) do: [ :pragma | 
		(self perform: pragma methodSelector with: otherEntity with: changes) ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #'*Famix-Diff-Core' }
TEntityMetaLevelDependency >> isParent: baseParent equivalentTo: targetParent givenChanges: changes [

	| baseParentChange targetParentChange |
	(baseParent isStub or: [ targetParent isStub ]) ifTrue: [ ^ baseParent mooseName = targetParent mooseName ].

	"If matching of one or both parent is unknown (absent from changes), they are most probably different because the calling algorithm treats parents first and identity matches first"
	baseParentChange := changes at: baseParent ifAbsent: [ ^ false ].
	targetParentChange := changes at: targetParent ifAbsent: [ ^ false ].
	^ baseParentChange = targetParentChange
]
