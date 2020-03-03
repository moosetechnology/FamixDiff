tests
testDiffEntitiesMatchP2
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	self runDiff.
	self assert: result entityChanges size equals: 16 / 2 "because in the old version result were duplicated".
	self assert: (result entityChanges select: [ :e | e isMatch ]) asSet size equals: 8