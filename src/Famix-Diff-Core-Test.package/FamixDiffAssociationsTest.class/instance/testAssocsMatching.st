tests
testAssocsMatching
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff').
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::C3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::C3diff').
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto').
	snapshot diffComputer changesDico: testChanges.
	snapshot diffComputer diffAssociations.

	"because the invocations of new (in A3.c3()) does not have candidates, an exception is added"
	self assert: snapshot assocChanges isEmpty