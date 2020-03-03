filtering-widgets
typeCheckBoxes
	| checkBoxesPart |
	checkBoxesPart := MultiCheckboxesPart new
		labels: (self changesComputation typesChanged collect: #asSymbol) asArray;
		callback: [ :assoc :part |
				assoc value
						ifTrue: [self queryWizardInfo add: assoc key  ]
						ifFalse: [self queryWizardInfo remove: assoc key ].
						part wizardPane isNotNil
						ifTrue: [part wizardPane removeSubComponentAt: 2.
						part wizardPane column: [:aCol | self createMetricsOn: aCol].
						part wizardPane refresh].
						
						];
		inGroupboxNamed: 'Types of Entities';
		deselectAllOptions;
		yourself.
		self typesFilter selection ifNotEmpty: [
		self typesFilter selection do: [:aType | checkBoxesPart selectOption: aType displayName asSymbol] ].
	^ checkBoxesPart