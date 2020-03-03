*Famix-Diff-Core
renameMatch: otherEntity givenChanges: changes tolerance: percentage
	| myParent otherParent |
	
	"stubs either are identical or nothing, no renaming or moving allowed"
	(self isStub) ifTrue: [  ^false ].
	(otherEntity isStub) ifTrue: [  ^false ].
	
	(self famixClass = otherEntity famixClass) ifFalse: [ ^ false ].
	(self name = otherEntity  name) ifTrue: [ ^ false ].

	myParent := self belongsTo.
	otherParent := otherEntity belongsTo.
	self parentPackage isNil
		ifFalse: [ myParent := self parentPackage.
				  otherParent := otherEntity parentPackage ].
	myParent isNil ifTrue: [ ^ otherParent isNil ].
	(otherParent isNil) ifTrue: [ ^ false ].
	^ (changes at: myParent ifAbsent: #unknown1) = (changes at: otherParent ifAbsent: #unknown2)
	"if matching of one or both parents is unknown then they are most probably different because the calling algorithm treats parents first and identity matches first"
