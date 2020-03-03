tests
testSelection
	| filter |
	filter := (FamixDiffChangesFilter new selection: {FamixAddChange}; yourself).
	self assert:  filter selection first equals: FamixAddChange.