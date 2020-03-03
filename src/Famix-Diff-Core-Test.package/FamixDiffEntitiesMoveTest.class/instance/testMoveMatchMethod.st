tests
testMoveMatchMethod
	"moving c3 metod"

	(snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()')
		parentType: (snapshot targetModel entityNamed: 'Smalltalk::A2diff').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				moveMatch: (snapshot targetModel entityNamed: 'Smalltalk::A2diff.c3()')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A2diff.c3()')
				moveMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges
				tolerance: 0)