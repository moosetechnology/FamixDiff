tests
testAssocsDelP4
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::B3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::B3diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::B4diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff.b3()').
	snapshot diffComputer changesDico: testChanges.
	snapshot diffComputer diffAssociations.
	self assert: snapshot diffComputer assocChanges size equals: 4.
	self
		assert: (snapshot diffComputer assocChanges select: [ :c | c isRemoval ]) size
		equals: 4