private
changesFilter
	^ changesFilter ifNil: [ changesFilter := FamixDiffChangesFilter new. ]