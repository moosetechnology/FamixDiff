Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> compareNameWith: otherEntity givenChanges: changes [

	<famixDiffIdentity>
	^ self name = otherEntity name
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
