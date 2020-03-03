running
testSortChanges
	| changes |
	changes := changesComputation sortChangesWith: {'Name LENGTH'.'Ascending'}.
	self assert: changes size equals: 3.
	self assert: changes last entity mooseName equals: #'Moose-TestResources-ModelDiff-P2'.
	changesComputation metricsSorter selection: {'Name LENGTH'.'Descending'}.
	changes := changesComputation metricsSorter computeResult.
	self assert: (changes last entity mooseName beginsWith:  'Smalltalk').
	
	