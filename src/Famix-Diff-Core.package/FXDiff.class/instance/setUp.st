private
setUp
	super setUp.
	self assert: (self baseModel isKindOf: MooseModel).
	self assert: (self targetModel isKindOf: MooseModel).
	self checkDiffComputer.
	self checkDiffTransformers.