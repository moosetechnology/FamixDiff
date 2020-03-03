*Famix-Diff-Core
identityMatch: otherEntity givenChanges: changes
	| myParent otherParent myParentChange otherParentChange |
	"same name, same class, matching parent"
	self famixClass = otherEntity famixClass
		ifFalse: [ ^ false ].
	self name = otherEntity name
		ifFalse: [ ^ false ].
	myParent := self belongsTo.
	otherParent := otherEntity belongsTo.
	(self parentPackage isNotNil or: [ otherEntity parentPackage isNotNil ])
		ifTrue: [ myParent := self parentPackage.
			otherParent := otherEntity parentPackage ].
	myParent ifNil: [ ^ otherParent isNil ].
	otherParent ifNil: [ ^ false ].
	myParent isStub
		ifTrue: [ ^ myParent mooseName = otherParent mooseName ].
	otherParent isStub
		ifTrue: [ ^ myParent mooseName = otherParent mooseName ].

	"If matching of one or both parent is unknown (absent from changes), they are most probably different because the calling algorithm treats parents first and identity matches first"
	myParentChange := changes at: myParent ifAbsent: [ ^ false ].
	otherParentChange := changes at: otherParent ifAbsent: [ ^ false ].
	^ myParentChange = otherParentChange