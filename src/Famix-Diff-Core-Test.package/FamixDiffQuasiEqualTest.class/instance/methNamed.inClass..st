running
methNamed: aString inClass: aFmxType
	^ (FAMIXMethod named: aString)
		parentType: aFmxType;
		yourself