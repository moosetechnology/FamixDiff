accessing
changes
	^ changes ifNil: [ changes := self famixDiffResult allEntitiesImpactingChanges asSet ]