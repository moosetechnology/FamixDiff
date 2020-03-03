*Famix-Diff-Core
identityMatch: otherEntity givenChanges: changes
	"Same class, same parents"

	self famixClass = otherEntity famixClass
		ifFalse: [ ^ false ].
	^ (self
		isMatchingMyParent: self belongsTo
		with: otherEntity belongsTo
		givenChanges: changes)
		and: [ self
				isMatchingMyParent: self annotationType
				with: otherEntity annotationType
				givenChanges: changes ]