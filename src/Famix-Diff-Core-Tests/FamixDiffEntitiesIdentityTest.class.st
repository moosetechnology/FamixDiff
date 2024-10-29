Class {
	#name : #FamixDiffEntitiesIdentityTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassMatching [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').

	self
		assertIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff')
		to: (self targetEntityNamed: 'Smalltalk::A3diff').
	self
		assertIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff')
		to: (self baseEntityNamed: 'Smalltalk::A3diff')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassNoMatch [

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self createChange: FamixAddChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P1').

	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff') 
		to:	 (self targetEntityNamed: 'Smalltalk::A2diff').
	self
		denyIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff') 
		to:	 (self baseEntityNamed: 'Smalltalk::A2diff').

]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassNoMatchPackageDifferent [
	"setup: create changes for parents"

	self createChange: FamixAddChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P1').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P3').

	"classes with same name but different packages"
	diff targetModel add: (FamixStClass new
			 name: 'A4diff';
			 parentPackage: (self targetEntityNamed: 'Famix-Diff-TestResource-P1');
			 typeContainer: (self targetEntityNamed: 'Smalltalk')).

	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A4diff')
		to: (self targetEntityNamed: 'Smalltalk::A4diff').
	self
		denyIdentityMatch: (self targetEntityNamed: 'Smalltalk::A4diff')
		to: (self baseEntityNamed: 'Smalltalk::A4diff').

]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassParentIsNil [
	"classes with same name but different packages"

	diff targetModel add: (FamixStClass new name: 'A4diff').
	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A4diff')
		to: (self targetEntityNamed: 'A4diff').
	self
		denyIdentityMatch: (self targetEntityNamed: 'A4diff')
		to: (self baseEntityNamed: 'Smalltalk::A4diff')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchCommentMatching [

	| baseCmt targetCmt |
	baseCmt := FamixStComment new
		           content: 'This is a comment';
		           commentedEntity:
			           (self baseEntityNamed: 'Smalltalk::B3diff.c3()');
		           yourself.
	targetCmt := FamixStComment new
		             content: 'This is a comment';
		             commentedEntity:
			             (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
		             yourself.

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::B3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::B3diff.c3()').

	self assertIdentityMatch: baseCmt to: targetCmt.
	self assertIdentityMatch: targetCmt to: baseCmt
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchCommentNotMatching [

	| baseCmt targetCmt |
	baseCmt := FamixStComment new
		           content: 'This is a comment';
		           commentedEntity:
			           (self baseEntityNamed: 'Smalltalk::B3diff.c3()');
		           yourself.
	targetCmt := FamixStComment new
		             content: 'This is another comment';
		             commentedEntity:
			             (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
		             yourself.

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::B3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::B3diff.c3()').

	self denyIdentityMatch: baseCmt to: targetCmt.
	self denyIdentityMatch: targetCmt to: baseCmt
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchLocalVariableMatching [
	"testing variable 'toto' against itself"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChange: FamixRemovalChange
		with: (self baseEntityNamed: 'Smalltalk::A4diff').

	self
		assertIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
		to: (self targetEntityNamed: 'Smalltalk::A3diff.c3().toto').
	self
		assertIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3().toto')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchLocalVariableNoMatch [
	"testing variable 'toto' against 'var2'"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChange: FamixRemovalChange
		with: (self baseEntityNamed: 'Smalltalk::A4diff').

	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
		to: (self targetEntityNamed: 'Smalltalk::A3diff.c3().var2').
	self
		denyIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3().var2')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchLocalVariableNoMatchSameName [
	"setup: create changes for parents"

	| newVar |
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChange: FamixRemovalChange
		with: (self baseEntityNamed: 'Smalltalk::A4diff').

	newVar := FamixStLocalVariable new
		name: 'toto';
		parentBehaviouralEntity: (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
		yourself.

	"testing variables 'toto'"
	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
		to: newVar.

	newVar := FamixStLocalVariable new
		name: 'toto';
		parentBehaviouralEntity: (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
		yourself.

	self
		denyIdentityMatch: newVar
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchMethodMatching [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff')
		and: (self targetEntityNamed: 'Smalltalk::A3diff').
	self
		createChange: FamixRemovalChange
		with: (self baseEntityNamed: 'Smalltalk::A4diff').

	self
		assertIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		to: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	self
		assertIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3()')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchMethodNoMatch [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff')
		and: (self targetEntityNamed: 'Smalltalk::A3diff').
	self
		createChange: FamixRemovalChange
		with: (self baseEntityNamed: 'Smalltalk::A4diff').

	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		to: (self targetEntityNamed: 'Smalltalk::A3diff.b2()').
	self
		denyIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.b3()')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchMethodNoMatchSameName [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff')
		and: (self targetEntityNamed: 'Smalltalk::A3diff').
	self
		createChange: FamixRemovalChange
		with: (self baseEntityNamed: 'Smalltalk::A4diff').

	self
		denyIdentityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		to: (self targetEntityNamed: 'Smalltalk::B3diff.c3()').
	self
		denyIdentityMatch: (self targetEntityNamed: 'Smalltalk::B3diff.c3()')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchPackageMatching [

	self
		assertIdentityMatch: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		to: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self
		assertIdentityMatch: (self targetEntityNamed: 'Famix-Diff-TestResource-P2')
		to: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchPackageNoMatch [

	self
		denyIdentityMatch: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		to: (self targetEntityNamed: 'Famix-Diff-TestResource-P1').
	self
		denyIdentityMatch: (self targetEntityNamed: 'Famix-Diff-TestResource-P1')
		to: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
]
