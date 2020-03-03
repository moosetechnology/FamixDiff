filtering-widgets
createMetricsOn: aCol
	self changeMetrics
		associationsDo: [ :indicator | 
			|metricsPanePart|
			aCol
				row: [ :row | 
					metricsPanePart := CheckboxPart new
						defaultValue: self defaultValueForCheckBoxes;
						label: indicator value;
						yourself.
					row column: metricsPanePart associatedTo: ('metric', indicator) asSymbol.
						row column:
								(TextFieldPart new
										prefix: 'Min';
										defaultValue: 0)
						associatedTo: ('min', indicator ) asSymbol;
						column:
								(TextFieldPart new
										prefix: 'Max';
										defaultValue: 10)
						associatedTo: ('max', indicator) asSymbol
					 ]
				].