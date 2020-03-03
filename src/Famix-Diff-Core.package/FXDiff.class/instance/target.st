accessing
target
	self
		deprecated: 'Please use #targetModel  instead'
		transformWith: '`@receiver target' 
						-> '`@receiver targetModel'.
	
	^ self targetModel