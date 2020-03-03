running
testTypesChangedAndMetics
	self assert: (changesComputation metricsFilter selectorForMetricName: ('Name length'))  equals: #nameLength.