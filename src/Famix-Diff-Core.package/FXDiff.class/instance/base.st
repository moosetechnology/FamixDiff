deprecated
base
	self
		deprecated: 'Please use #baseModel  instead'
		transformWith: '`@receiver base' 
						-> '`@receiver baseModel'.
	
	^ self baseModel