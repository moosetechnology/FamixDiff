Class {
	#name : #FamixDiffAssociationsTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffAssociationsTest >> testAssocsAddP2 [

	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.C3diff') and: (self targetEntityNamed: 'Smalltalk.C3diff').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk.A3diff').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk.A3diff.c3()').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk.A3diff.c3().toto').
	self createChange: FamixAddChange with: (self targetEntityNamed: 'Smalltalk.A3diff').
	self createChange: FamixAddChange with: (self targetEntityNamed: 'Smalltalk.A3diff.c3()').
	self createChange: FamixAddChange with: (self targetEntityNamed: 'Smalltalk.A3diff.c3().toto').
	diff resolver computeDiffBetweenAssociations.
	self assert: diff resolver associationChanges size equals: 8.
	self assert: (diff resolver associationChanges select: [ :c | c isAddition ]) size equals: 4.
	self assert: (diff resolver associationChanges select: [ :c | c isRemoval ]) size equals: 4
]

{ #category : #tests }
FamixDiffAssociationsTest >> testAssocsDelP3 [

	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.B3diff') and: (self targetEntityNamed: 'Smalltalk.B3diff').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk.A4diff').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk.B4diff').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk.A4diff.b3()').
	diff resolver computeDiffBetweenAssociations.
	self assert: diff resolver associationChanges size equals: 4.
	self assert: (diff resolver associationChanges select: [ :c | c isRemoval ]) size equals: 4
]

{ #category : #tests }
FamixDiffAssociationsTest >> testAssocsMatching [

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.A3diff') and: (self targetEntityNamed: 'Smalltalk.A3diff').
	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.C3diff') and: (self targetEntityNamed: 'Smalltalk.C3diff').
	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.A3diff.c3()') and: (self targetEntityNamed: 'Smalltalk.A3diff.c3()').
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk.A3diff.c3().toto')
		and: (self targetEntityNamed: 'Smalltalk.A3diff.c3().toto').
	diff resolver computeDiffBetweenAssociations.

	"because the invocations of new (in A3.c3()) does not have candidates, an exception is added"
	self assertEmpty: diff associationChanges
]
