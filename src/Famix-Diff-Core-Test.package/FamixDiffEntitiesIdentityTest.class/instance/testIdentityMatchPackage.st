tests
testIdentityMatchPackage
	self
		assert:
			((snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				identityMatch: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				identityMatch: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges).
	self
		deny:
			((snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				identityMatch: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2')
				identityMatch: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges)