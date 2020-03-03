comparing
= anObject
	^ (anObject class = self class) and: [ 
			anObject entity = self entity ]