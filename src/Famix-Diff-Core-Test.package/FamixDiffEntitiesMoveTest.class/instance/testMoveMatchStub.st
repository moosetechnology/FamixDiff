tests
testMoveMatchStub
	| basA3 tgtA3 basA3c3 tgtA3c3 |
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'.
	self
		assert: (basA3c3 moveMatch: tgtA3c3 givenChanges: testChanges tolerance: 0).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self
		deny: (basA3c3 moveMatch: tgtA3c3 givenChanges: testChanges tolerance: 0).
	self
		assert: (basA3 moveMatch: tgtA3 givenChanges: testChanges tolerance: 0).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self
		deny: (basA3 moveMatch: tgtA3 givenChanges: testChanges tolerance: 0)