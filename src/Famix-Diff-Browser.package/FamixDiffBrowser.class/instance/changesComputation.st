accessing
changesComputation
	^ changesComputation ifNil: [ changesComputation := FamixDiffChangesComputation new ]