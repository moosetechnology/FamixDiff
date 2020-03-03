running
testTypesChangedCustomMetrics
	| metricsSelected |
	metricsSelected := changesComputation changeMetricsFor: #('Class').
	self assert: metricsSelected size equals: 1.
	self assert: (metricsSelected keys includes: #Class).
	self assert: (metricsSelected at: #Class) size equals: 8.