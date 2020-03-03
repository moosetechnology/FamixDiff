tests
testIdentityMatchMethod
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.b2()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.b3()')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges)