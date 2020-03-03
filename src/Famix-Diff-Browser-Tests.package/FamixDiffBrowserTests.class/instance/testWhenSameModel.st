tests
testWhenSameModel
	self transmitBase.
	self transmitTarget.
	((browserWindow model paneNamed: #targetModel) port: #selection) value: baseModel.
	self assert: (browserWindow model paneNamed: #changesList) presentations first dynamicActions size equals: 0.
	