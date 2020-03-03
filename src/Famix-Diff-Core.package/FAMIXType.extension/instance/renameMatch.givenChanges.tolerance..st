*Famix-Diff-Core
renameMatch: otherEntity givenChanges: changes tolerance: percentage
	(super renameMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: percentage