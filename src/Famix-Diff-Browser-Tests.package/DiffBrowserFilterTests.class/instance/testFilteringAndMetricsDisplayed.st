tests
testFilteringAndMetricsDisplayed
	| wizardSorter |
	wizardSorter := (FamixDiffQueryWizard new browser: diffBrowser).
	self assert: wizardSorter changeMetrics size equals: 8.
	wizardSorter typesSelected remove: #Class.
	self assert: wizardSorter changeMetrics size equals: 1.