accessing
base
	self
		deprecated: 'Use baseModel instead'
		on: '17 November 2016'
		in: 'Pharo-6.0-60294-'
		transformWith: '`@receiver base' -> '`@receiver baseModel'.
	^ self baseModel