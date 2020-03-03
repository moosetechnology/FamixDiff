tests
testIdentityMatchClassNot
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		createChg: FamixAddChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P2').

	"tests"
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A2diff')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A2diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges)