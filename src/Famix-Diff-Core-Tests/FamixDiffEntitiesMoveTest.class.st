Class {
	#name : #FamixDiffEntitiesMoveTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchClass [

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self
		createChange: FamixAddChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P1').

	"changing package of A3 in target model"
	(self targetEntityNamed: 'Smalltalk::A3diff') parentPackage:
		(self targetEntityNamed: 'Famix-Diff-TestResource-P1').

	self
		assertMoveMatch: (self baseEntityNamed: 'Smalltalk::A3diff')
		to: (self targetEntityNamed: 'Smalltalk::A3diff').
	self
		assertMoveMatch: (self targetEntityNamed: 'Smalltalk::A3diff')
		to: (self baseEntityNamed: 'Smalltalk::A3diff')
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchCommentNoMatch [
	"Comments are never moved"

	| baseCmt targetCmt |
	baseCmt := FamixStComment new
		content: 'This is a comment';
		commentedEntity: (self baseEntityNamed: 'Smalltalk::B3diff.c3()');
		yourself.
	targetCmt := FamixStComment new
		content: 'This is a comment';
		commentedEntity: (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
		yourself.

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::B3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::B3diff.c3()').

	self denyMoveMatch: baseCmt to: targetCmt.
	self denyMoveMatch: targetCmt to: baseCmt
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchMethod [
	"moving c3 metod"

	(self targetEntityNamed: 'Smalltalk::A3diff.c3()') parentType:
		(self targetEntityNamed: 'Smalltalk::A2diff').

	self
		assertMoveMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		to: (self targetEntityNamed: 'Smalltalk::A2diff.c3()').
	self
		assertMoveMatch: (self targetEntityNamed: 'Smalltalk::A2diff.c3()')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchVariableMatching [
	"MoveMatching of variables depends on accesses
	 Create one access for the matching to happen"

	| var1 var2 |
	var1 := self baseEntityNamed: 'Smalltalk::A3diff.c3().toto'.
	var2 := self targetEntityNamed: 'Smalltalk::B3diff.c3().toto'.

	FamixStAccess new
		variable: var1;
		accessor: (self baseEntityNamed: 'Smalltalk::A3diff.b3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk::A3diff.b3()').

	self assertMoveMatch: var1 to: var2.
	self assertMoveMatch: var2 to: var1
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchVariableNoMatch [
	"MoveMatching of variables depends on accesses
	 Here there is not enough (need at least 1)"

	| var1 var2 |

	var1 := self baseEntityNamed: 'Smalltalk::A3diff.c3().toto'.
	var2 := self targetEntityNamed: 'Smalltalk::B3diff.c3().toto'.

	self denyMoveMatch: var1 to: var2.
	self denyMoveMatch: var2 to: var1.

]
