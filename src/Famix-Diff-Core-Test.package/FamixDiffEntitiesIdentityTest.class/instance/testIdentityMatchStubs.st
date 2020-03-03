tests
testIdentityMatchStubs
	| basP3 tgtP3 basA3 tgtA3 basA3c3 tgtA3c3 tgtB3c3 basA3c3toto tgtA3c3toto |
	basP3 := snapshot baseModel
		entityNamed: 'Moose-TestResources-ModelDiff-P3'.
	tgtP3 := snapshot targetModel
		entityNamed: 'Moose-TestResources-ModelDiff-P3'.
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtB3c3 := snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()'.
	basA3c3toto := snapshot baseModel
		entityNamed: 'Smalltalk::A3diff.c3().toto'.
	tgtA3c3toto := snapshot targetModel
		entityNamed: 'Smalltalk::A3diff.c3().toto'.
	basP3 isStub: true.
	tgtP3 isStub: true.
	basA3 isStub: true.
	tgtA3 isStub: true.
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	tgtB3c3 isStub: true.
	basA3c3toto isStub: true.
	tgtA3c3toto isStub: true.
	self assert: (basP3 identityMatch: tgtP3 givenChanges: testChanges).
	self createChg: FamixVersionChange with: basP3 and: tgtP3.
	self assert: (basA3 identityMatch: tgtA3 givenChanges: testChanges).
	self createChg: FamixVersionChange with: basA3 and: tgtA3.
	self
		assert: (basA3c3 identityMatch: tgtA3c3 givenChanges: testChanges).
	self deny: (basA3c3 identityMatch: tgtB3c3 givenChanges: testChanges).
	self createChg: FamixVersionChange with: basA3c3 and: tgtA3c3.
	self
		assert: (basA3c3toto identityMatch: tgtA3c3toto givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges)