tests
testRenameMatchStub
	| basA3 tgtA3 basA3c3 tgtA3c3 basP3 tgtP3 |
	basP3 := snapshot baseModel
		entityNamed: 'Moose-TestResources-ModelDiff-P3'.
	tgtP3 := snapshot targetModel
		entityNamed: 'Moose-TestResources-ModelDiff-P3'.
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'.	"self assert: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges)."
	self createChg: FamixVersionChange with: basP3 and: tgtP3.
	tgtA3 name: 'X3'.
	self
		assert: (basA3 renameMatch: tgtA3 givenChanges: testChanges tolerance: 0).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self
		deny: (basA3 renameMatch: tgtA3 givenChanges: testChanges tolerance: 0).
	self createChg: FamixVersionChange with: basA3 and: tgtA3.
	tgtA3c3 name: 'x3'.
	tgtA3c3 signature: 'x3()'.
	self
		assert: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges tolerance: 0).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self
		deny: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges tolerance: 0)