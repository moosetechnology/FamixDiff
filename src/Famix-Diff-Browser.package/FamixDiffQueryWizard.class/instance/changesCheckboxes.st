filtering-widgets
changesCheckboxes
	|checkBoxesPart|
	checkBoxesPart := (MultiCheckboxesPart new
		labels: (self changesComputation changeTypes collect: #asSymbol) asArray; 
		inGroupboxNamed: 'Types of Changes';
		deselectAllOptions;
		yourself).	
	self changesFilter selection ifNotEmpty: [
		self changesFilter selection do: [:aChangeType | checkBoxesPart selectOption: aChangeType displayName asSymbol] ].
	^ checkBoxesPart