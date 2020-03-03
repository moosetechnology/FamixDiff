filtering-widgets
filterSelectionChooser
	|  wizardPane1 wizardControl|
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	self createQueryFilterBox: wizardPane1.
	wizardControl addPane: wizardPane1.
	wizardControl atEndDo: [ :aDictionaryOfSelections | self filterChangesWith: aDictionaryOfSelections ].
	wizardControl open.