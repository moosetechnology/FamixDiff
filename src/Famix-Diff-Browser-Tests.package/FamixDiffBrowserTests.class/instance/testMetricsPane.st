tests
testMetricsPane
	self transmitBase.
	self transmitTarget.
	((browserWindow model paneNamed: #changesList) port: #selection) value: (self changes reject: #isForAssociation) last.
	self assert: (browserWindow model paneNamed: #metrics) presentations first displayValue size equals:9