tests
testIdentityMatchClassSame
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges)