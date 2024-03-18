Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> allAssociations [
	^ self queryAllLocalIncoming union: self queryAllLocalOutgoing
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> identityMatch: otherEntity givenChanges: changes [

	| myParent otherParent myParentChange otherParentChange |
	"same name, same class, matching parent"
	self class = otherEntity class ifFalse: [ ^ false ].
	self name = otherEntity name ifFalse: [ ^ false ].
	myParent := self belongsTo.
	otherParent := otherEntity belongsTo.
	(self parentPackage isNotNil or: [ otherEntity parentPackage isNotNil ]) ifTrue: [ 
		myParent := self parentPackage.
		otherParent := otherEntity parentPackage ].
	myParent ifNil: [ ^ otherParent isNil ].
	otherParent ifNil: [ ^ false ].
	myParent isStub ifTrue: [ ^ myParent mooseName = otherParent mooseName ].
	otherParent isStub ifTrue: [ ^ myParent mooseName = otherParent mooseName ].

	"If matching of one or both parent is unknown (absent from changes), they are most probably different because the calling algorithm treats parents first and identity matches first"
	myParentChange := changes at: myParent ifAbsent: [ ^ false ].
	otherParentChange := changes at: otherParent ifAbsent: [ ^ false ].
	^ myParentChange = otherParentChange
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [

	| myParent otherParent |
	"stubs either are identical or nothing, no renaming or moving allowed"
	self isStub ifTrue: [ ^ false ].
	otherEntity isStub ifTrue: [ ^ false ].
	self class = otherEntity class ifFalse: [ ^ false ].
	self name = otherEntity name ifFalse: [ ^ false ].
	myParent := self belongsTo.
	otherParent := otherEntity belongsTo.
	self parentPackage ifNotNil: [ 
		myParent := self parentPackage.
		otherParent := otherEntity parentPackage ].
	myParent ifNil: [ ^ otherParent notNil ].
	otherParent ifNil: [ ^ true ].
	^ (changes at: myParent ifAbsent: #unknown1) ~= (changes at: otherParent ifAbsent: #unknown2)
	"if matching of one or both parents is unknown then they are most probably different (which is what we want for a MOVE) because the calling algorithm treats parents first and identity matches first"
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> renameMatch: otherEntity givenChanges: changes tolerance: percentage [

	| myParent otherParent |
	"stubs either are identical or nothing, no renaming or moving allowed"
	self isStub ifTrue: [ ^ false ].
	otherEntity isStub ifTrue: [ ^ false ].

	self class = otherEntity class ifFalse: [ ^ false ].
	self name = otherEntity name ifTrue: [ ^ false ].

	myParent := self belongsTo.
	otherParent := otherEntity belongsTo.
	self parentPackage ifNotNil: [ 
		myParent := self parentPackage.
		otherParent := otherEntity parentPackage ].
	myParent ifNil: [ ^ otherParent isNil ].
	otherParent ifNil: [ ^ false ].
	^ (changes at: myParent ifAbsent: #unknown1) = (changes at: otherParent ifAbsent: #unknown2)
	"if matching of one or both parents is unknown then they are most probably different because the calling algorithm treats parents first and identity matches first"
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> shouldBeConsideredForDiff [
	^ true
]
