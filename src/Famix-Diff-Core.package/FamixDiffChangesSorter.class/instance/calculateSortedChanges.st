computation
calculateSortedChanges
	| entitiesAdded entitiesRemoved |
	entitiesAdded := self calculateChangesOrderOf: self result kindOfEntityAdditionChanges.
	entitiesRemoved := (self calculateChangesOrderOf: self result removalChanges) reverse.
	^ entitiesAdded
		addAll: self result kindOfAssocAdditionChanges asSet;
		addAll: self result versionChanges;
		addAll: self result assocRemovalChanges asSet;
		addAll: entitiesRemoved;
		yourself