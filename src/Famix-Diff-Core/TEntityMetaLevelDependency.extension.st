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
TEntityMetaLevelDependency >> identityMatch: otherEntity resolver: aFamixDiffResolver [

	self class = otherEntity class ifFalse: [ ^ false ].

	"We consider that the entities are identical if all comparators declared for the entity with the following pragma are matching."
	(Pragma allNamed: #famixDiffIdentity from: self class to: ProtoObject) do: [ :pragma | 
		(self perform: pragma methodSelector with: otherEntity with: aFamixDiffResolver changes) ifFalse: [ ^ false ] ].

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

{ #category : #'*Famix-Diff-Core' }
TEntityMetaLevelDependency >> renameMatch: aFAMIXMethod givenChanges: aCollection tolerance: anInteger [

	^ false
]
