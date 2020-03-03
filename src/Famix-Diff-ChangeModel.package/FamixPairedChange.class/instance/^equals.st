comparing
= anObject
	^ super = anObject and: [ 
		anObject targetEntity = self targetEntity ]