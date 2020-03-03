running
testNumberOfChanges
	self assert: changesComputation changes size equals: 3.
	self assert: changesComputation displayedChanges size equals: 3.
	self deny: changesComputation famixDiff isNil