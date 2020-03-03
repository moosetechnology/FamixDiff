tests
testSorting
	self sorter selection: {'Number of attributes'.'Descending'}.
	(diffBrowser displayedChanges: self sorter computeResult).
	self assert: diffBrowser displayedChanges size equals: 2.
	self assert: (diffBrowser displayedChanges first entity mooseName beginsWith: 'Smalltalk').