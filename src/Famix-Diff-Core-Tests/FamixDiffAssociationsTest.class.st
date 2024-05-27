Class {
	#name : #FamixDiffAssociationsTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffAssociationsTest >> testAssocsAddP2 [
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::C3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::C3diff').
	self
		createChange: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff').
	self
		createChange: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChange: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto').
	self
		createChange: FamixAddChange
		with: (snapshot targetModel entityNamed: 'Smalltalk::A3diff').
	self
		createChange: FamixAddChange
		with: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChange: FamixAddChange
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
]

{ #category : #tests }
FamixDiffAssociationsTest >> testAssocsDelP3 [
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::B3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::B3diff').
	self
		createChange: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff').
	self
		createChange: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::B4diff').
	self
		createChange: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff.b3()').
	snapshot diffComputer changesDico: testChanges.
	snapshot diffComputer diffAssociations.
	self assert: snapshot diffComputer assocChanges size equals: 4.
	self
		assert: (snapshot diffComputer assocChanges select: [ :c | c isRemoval ]) size
		equals: 4
]

{ #category : #tests }
FamixDiffAssociationsTest >> testAssocsMatching [
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P2')
		and: (snapshot targetModel entityNamed: 'Famix-Diff-TestResource-P2').
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff').
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::C3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::C3diff').
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto').
	snapshot diffComputer changesDico: testChanges.
	snapshot diffComputer diffAssociations.

	"because the invocations of new (in A3.c3()) does not have candidates, an exception is added"
	self assert: snapshot assocChanges isEmpty
]
