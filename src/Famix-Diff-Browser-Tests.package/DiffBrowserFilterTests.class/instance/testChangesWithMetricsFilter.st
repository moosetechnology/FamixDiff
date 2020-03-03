tests
testChangesWithMetricsFilter
	self assert: diffBrowser displayedChanges size equals: 3.
	changesComputation metricsFilter changes: diffBrowser displayedChanges.
	changesComputation metricsFilter selection: { 'Name Length'-> #(30 40)}  asDictionary.
	(diffBrowser displayedChanges: changesComputation metricsFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 1.
	self assert: changesComputation metricsFilter userThresholds first min equals: 30.
	self assert: changesComputation metricsFilter userThresholds first selector equals: #nameLength.
	self assert: changesComputation metricsFilter userThresholds first max equals: 40.
	self assert: diffBrowser displayedChanges size equals: 1.
	self assert: changesComputation displayedChanges size equals: 1.
	self assert: changesComputation changes size equals:  3