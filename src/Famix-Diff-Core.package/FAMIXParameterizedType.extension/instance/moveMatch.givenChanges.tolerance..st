*Famix-Diff-Core
moveMatch: otherEntity givenChanges: changes tolerance: percentage
	(super moveMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self equalArguments: otherEntity tolerance: percentage