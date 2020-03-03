filtering-widgets
createQueryFilterBox: wizardPane
	wizardPane column: [:aColumn |
		aColumn row: (self changesCheckboxes) associatedTo: #selectedChanges.
		aColumn row: (self typeCheckBoxes) associatedTo: #selectedTypes].
	wizardPane column: [:aCol | self createMetricsOn: aCol].
	