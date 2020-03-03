*Famix-Diff-Core
isMatchingMyParent: myParent with: otherEntityParent givenChanges: changes
	myParent ifNil: [ ^ otherEntityParent isNil ].
	otherEntityParent ifNil: [ ^ false ].
	myParent isStub
		ifTrue: [ ^ myParent mooseName = otherEntityParent mooseName ].
	otherEntityParent isStub
		ifTrue: [ ^ myParent mooseName = otherEntityParent mooseName ].

	^ (changes at: myParent ifAbsent: [ ^ false ]) = (changes at: otherEntityParent ifAbsent: [ ^ false ])