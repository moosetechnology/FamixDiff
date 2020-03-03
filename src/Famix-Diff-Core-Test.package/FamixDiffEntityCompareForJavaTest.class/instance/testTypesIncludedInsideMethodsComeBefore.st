tests
testTypesIncludedInsideMethodsComeBefore
	|  methodsWithTypes method |
	methodsWithTypes := model allMethods select: [ :m | m types isNotEmpty ].
	method := methodsWithTypes entityNamed: #'<Default Package>::Dictionary.createFamixEntity(Class<T>,String)'.
	self deny: (method types first comeBeforeEntity: method).
	self assert: (method comeBeforeEntity: method types first).
	