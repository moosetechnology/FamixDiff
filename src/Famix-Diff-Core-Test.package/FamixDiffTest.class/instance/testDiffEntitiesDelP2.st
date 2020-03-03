tests
testDiffEntitiesDelP2
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	snapshot targetModel: MooseModel new.
	self runDiff.
	self assert: result entityChanges size equals: 8.
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 8	"Smalltalk P2 A2 B2 + stubs: ProtoObject Object Kernel Object.DependentsFields"