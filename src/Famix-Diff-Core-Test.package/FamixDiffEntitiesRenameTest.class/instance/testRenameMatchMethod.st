tests
testRenameMatchMethod
	(snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()')
		name: 'x3'.
	(snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()')
		signature: 'x3()'.
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::B3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::B3diff').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::B3diff.c3()')
				renameMatch: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.x3()')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::B3diff.x3()')
				renameMatch: (snapshot baseModel entityNamed: 'Smalltalk::B3diff.c3()')
				givenChanges: testChanges
				tolerance: 0)