tests
testIdentityMatchClassParentIsNil
	"classes with same name but different packages"

	snapshot targetModel add: (FAMIXClass new name: 'A4diff').
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				identityMatch: (snapshot targetModel entityNamed: 'A4diff')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'A4diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				givenChanges: testChanges)