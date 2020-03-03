tests
testIdentityMatchVariable
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff').

	"testing variable 'toto'"
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges).

	"testing variable 'toto' against 'var2'"
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().var2')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().var2')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges).

	"testing variables 'toto'"
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch:
					(FAMIXLocalVariable new
						name: 'toto';
						parentBehaviouralEntity: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()');
						yourself)
				givenChanges: testChanges).
	self
		deny:
			((FAMIXLocalVariable new
				name: 'toto';
				parentBehaviouralEntity: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()');
				yourself)
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges)