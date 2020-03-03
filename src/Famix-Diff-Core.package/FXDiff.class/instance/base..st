deprecated
base: aMooseModel
	self deprecated: 'Please use #baseModel:  instead' transformWith: '`@receiver base: `@statements1' -> '`@receiver baseModel: `@statements1'.
	^ self baseModel: aMooseModel