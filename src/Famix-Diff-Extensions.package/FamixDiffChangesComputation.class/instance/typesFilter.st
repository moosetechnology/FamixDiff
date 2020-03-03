private
typesFilter
	^ typesFilter ifNil: [ typesFilter := FamixDiffTypeFilter new changes: self changes; yourself. ]