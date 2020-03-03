tests
testSortingWithWizardFormat
	| sorterWizard |
	sorterWizard := FamixDiffSorterWizard new browser: diffBrowser; yourself.
	sorterWizard sortChangesWith: {#sortDirection->'Descending'. #sorterMetric-> 'Name Length'} asDictionary.
	self assert: (diffBrowser displayedChanges last entity mooseName beginsWith: 'Smalltalk').