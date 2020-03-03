sorting
entitiesAddAndChangesSorted
	^ (self result entityChanges reject: [ :change | change isRemoval ]) asSet
		sorted: [ :a :b | a comeBeforeOrIsEquivalent: b ]