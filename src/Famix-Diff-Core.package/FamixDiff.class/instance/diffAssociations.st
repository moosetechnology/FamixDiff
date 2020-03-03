run-associations
diffAssociations
	(self changesDico values asSet asOrderedCollection
		"sorted: [ :a :b | a printString <= b printString ]")
		do: [ :chg | chg updateDiffForAssociations: self ]
		"displayingProgress: 'Comparing entity associations'"