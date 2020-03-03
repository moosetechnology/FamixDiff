running
attNamed: aString inClass: aFmxType
	^ (FAMIXAttribute named: aString)
		parentType: aFmxType;
		yourself