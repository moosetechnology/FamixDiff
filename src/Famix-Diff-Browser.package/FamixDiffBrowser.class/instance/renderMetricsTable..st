render
renderMetricsTable: a
	a table
		display: [ :change | self indicatorsFor: change];
		sorted: [:chg1 :chg2 | chg1 label < chg2 label ];
		column: [ :x | 'Metric' ] evaluated: #label;
		column: 'Delta Value' evaluated: [:each | (each computedValue isKindOf: Number) 
				ifTrue: [each computedValue asInteger asStringWithCommasSigned] ifFalse: [each computedValue asString]]
	