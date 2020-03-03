*Famix-Diff-Core
matches: otherAssoc givenChanges: entityChanges
	self famixClass = otherAssoc famixClass
		ifFalse: [ ^ false ].

	"this test could be simplified because the 'from' cannot be a Stub in any association"
	(self myEntity: self from matches: otherAssoc from givenChanges: entityChanges)
		ifFalse: [ ^ false ].
	^ self myEntity: self to matches: otherAssoc to givenChanges: entityChanges