tests
testIdentityMatchClassNotPackageDifferent
	"setup: create changes for parents"

	self
		createChg: FamixAddChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P2').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P4').

	"classes with same name but different packages"
	snapshot targetModel
		add:
			(FAMIXClass new
				name: 'A4diff';
				parentPackage: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2');
				container: (snapshot targetModel entityNamed: 'Smalltalk')).
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A4diff')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A4diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				givenChanges: testChanges)