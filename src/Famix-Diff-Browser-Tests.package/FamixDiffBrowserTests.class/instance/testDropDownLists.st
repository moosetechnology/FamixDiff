tests
testDropDownLists
	self assert: (browserWindow model paneNamed: #baseModel) presentations first displayValue size equals: 2.
	self assert: (browserWindow model paneNamed: #targetModel) presentations first displayValue size equals: 2.
	self assert: (browserWindow model paneNamed: #targetModel) presentations first displayValue first equals: baseModel.
	self assert: (browserWindow model paneNamed: #baseModel) presentations first displayValue second equals: targetModel.