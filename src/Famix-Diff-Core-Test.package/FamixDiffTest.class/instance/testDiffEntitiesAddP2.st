tests
testDiffEntitiesAddP2
	snapshot baseModel: MooseModel new.
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	self runDiff.
	self assert: result entityChanges size equals: 8.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 8	"Smalltalk P2 A2 B2 + stubs: ProtoObject Object Kernel Object.DependentsFields"