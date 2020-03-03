tests
testActionsWhenChangesEmpty
	self assert: (browserWindow model paneNamed: #changesList) presentations first dynamicActions size equals: 2.
	changesComputation typesFilter changes: changesComputation changes.
	changesComputation typesFilter selection: { }.
	(changesComputation displayedChanges: changesComputation typesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 0.
	self assert: diffBrowser displayedChanges size equals: changesComputation displayedChanges size.
	self assert: (browserWindow model paneNamed: #changesList) presentations first dynamicActions size equals: 0.