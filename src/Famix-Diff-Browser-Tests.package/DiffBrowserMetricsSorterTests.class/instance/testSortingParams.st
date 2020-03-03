tests
testSortingParams
	diffBrowser displayedChanges: (diffBrowser changesComputation metricsSorter changes: diffBrowser displayedChanges; selection: {'Name LEngth'.'Ascending'}; computeResult).
	self assert: diffBrowser displayedChanges last entity mooseName equals: #'Moose-TestResources-ModelDiff-P2'