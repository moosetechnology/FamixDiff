sorting
sorterMetricChooser
	^ RadioButtonsPart new
			options: self changeMetrics asArray sorted;
			inGroupboxNamed: 'Select Metric to Sort';
			defaultValue: self selectedOption;
			yourself
	