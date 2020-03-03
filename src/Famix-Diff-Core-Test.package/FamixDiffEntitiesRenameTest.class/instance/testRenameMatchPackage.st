tests
testRenameMatchPackage
	(snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		name: 'Moose-TestResources-ModelDiff-X0'.
	self
		assert:
			((snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				renameMatch: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-X0')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-X0')
				renameMatch: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges
				tolerance: 0)