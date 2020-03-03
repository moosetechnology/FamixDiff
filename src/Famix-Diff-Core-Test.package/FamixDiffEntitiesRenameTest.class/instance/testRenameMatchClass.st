tests
testRenameMatchClass
	(snapshot targetModel entityNamed: 'Smalltalk::A3diff')
		name: 'X3diff'.
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				renameMatch: (snapshot targetModel entityNamed: 'Smalltalk::X3diff')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::X3diff')
				renameMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges
				tolerance: 0)