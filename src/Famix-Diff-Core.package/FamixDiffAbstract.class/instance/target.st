deprecated
target
	self 
		deprecated: 'Use targetModel instead'
		on: 	'17 November 2016' 
		in: 'Pharo-6.0-60294-'
		transformWith: '`@receiver target' -> '`@receiver targetModel'..
	^ self targetModel