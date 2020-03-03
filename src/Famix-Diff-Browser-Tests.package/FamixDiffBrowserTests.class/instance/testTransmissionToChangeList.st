tests
testTransmissionToChangeList
	self transmitBase.
	self transmitTarget.
	self assert: (self browserWindow model paneNamed: #changesList) presentations first displayValue size equals: 3.
	self assert: ((self browserWindow model paneNamed: #changesList) port: #entity) value size equals: 3.