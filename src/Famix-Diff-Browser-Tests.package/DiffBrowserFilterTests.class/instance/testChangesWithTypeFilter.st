tests
testChangesWithTypeFilter
	self assert: diffBrowser displayedChanges size equals: 3.
	changesComputation typesFilter changes: diffBrowser displayedChanges.
	changesComputation typesFilter selection: { FAMIXClass }.
	(diffBrowser displayedChanges: changesComputation typesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 2.
	self assert: changesComputation typesFilter selection first equals: FAMIXClass.
	changesComputation typesFilter selection: { FAMIXPackage. FAMIXClass }.
	(diffBrowser displayedChanges: changesComputation typesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 3.