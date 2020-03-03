running
testTypesChanged
	self assert: changesComputation typesChanged size equals: 2.
	self assert: (changesComputation typesChanged includes: FAMIXPackage displayName).
	self assert: (changesComputation typesChanged includes: FAMIXClass displayName)