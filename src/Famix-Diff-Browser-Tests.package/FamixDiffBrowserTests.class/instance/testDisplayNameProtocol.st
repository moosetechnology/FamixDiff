tests
testDisplayNameProtocol
	FamixChange subclasses do: [:aClass | self assert: (aClass respondsTo: #displayName) ]