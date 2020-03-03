tests
testSortingAndSelectedMetrics
	| sorterWizard |
	sorterWizard := FamixDiffSorterWizard new browser: diffBrowser; yourself.
	self assert: (sorterWizard changeMetrics) size equals: 8.
	sorterWizard filterChangesWith:  { #selectedChanges -> {#Add->true}. #selectedTypes -> {#Package->true. #Behaviour->false}. #'metricName Length'->true. #'maxName Length'->'40'. #'minName Length'->'30'} asDictionary.
	self assert: (sorterWizard changeMetrics ) size equals: 1.