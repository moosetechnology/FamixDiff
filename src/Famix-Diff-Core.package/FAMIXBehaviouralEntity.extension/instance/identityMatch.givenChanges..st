*Famix-Diff-Core
identityMatch: otherEntity givenChanges: changes
	^ (super identityMatch: otherEntity givenChanges: changes)
		and: [ self signature = otherEntity signature ]