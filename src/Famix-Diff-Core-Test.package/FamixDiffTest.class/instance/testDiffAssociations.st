tests
testDiffAssociations
	snapshot
		baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3'));
		targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	self assert: result assocChanges size equals: 6.
	self assert: (result assocChanges select: [ :c | c isAddition ]) size equals: 2.
	self assert: (result assocChanges select: [ :c | c isRemoval ]) size equals: 4