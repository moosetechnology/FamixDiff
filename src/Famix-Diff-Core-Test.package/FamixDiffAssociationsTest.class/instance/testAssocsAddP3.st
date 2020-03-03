tests
testAssocsAddP3
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::C3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::C3diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto').
	self
		createChg: FamixAddChange
		with: (snapshot targetModel entityNamed: 'Smalltalk::A3diff').
	self
		createChg: FamixAddChange
		with: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChg: FamixAddChange
		with: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto').
	snapshot diffComputer changesDico: testChanges.
	snapshot diffComputer diffAssociations.
	self assert: snapshot diffComputer assocChanges size equals: 8.
	self
		assert: (snapshot diffComputer assocChanges select: [ :c | c isAddition ]) size
		equals: 4.
	self
		assert: (snapshot diffComputer assocChanges select: [ :c | c isRemoval ]) size
		equals: 4