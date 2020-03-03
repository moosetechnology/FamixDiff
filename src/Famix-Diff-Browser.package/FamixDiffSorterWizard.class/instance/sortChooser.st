sorting
sortChooser
	| wizardPane1 wizardControl |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	wizardPane1 row: self sortDirection associatedTo: #sortDirection.
	wizardPane1 row: self sorterMetricChooser associatedTo: #sorterMetric.
	wizardControl addPane: wizardPane1.
	wizardControl atEndDo: [ :aDictionaryOfSelections | self sortChangesWith: aDictionaryOfSelections ].
	wizardControl open