tests
testMoveMatchClass
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		createChg: FamixAddChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P2').	"changing package of A3 in target model"
	(snapshot targetModel entityNamed: 'Smalltalk::A3diff')
		parentPackage: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				moveMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				moveMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges
				tolerance: 0)