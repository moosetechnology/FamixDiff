Class {
	#name : #FamixDiffEntitiesRenameTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchClass [

	(self targetEntityNamed: 'Smalltalk.A3diff') name: 'X3diff'.
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').

	self
		assertRenameMatch: (self baseEntityNamed: 'Smalltalk.A3diff')
		to: (self targetEntityNamed: 'Smalltalk.X3diff').
	self
		assertRenameMatch: (self targetEntityNamed: 'Smalltalk.X3diff')
		to: (self baseEntityNamed: 'Smalltalk.A3diff')
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchCommentMatching [

	| baseCmt targetCmt |
	baseCmt := FamixStComment new
		           sourceAnchor: (FamixStSourceTextAnchor source: 'This is a comments');
		           commentedEntity: (self baseEntityNamed: 'Smalltalk.B3diff.c3()');
		           yourself.
	targetCmt := FamixStComment new
		             sourceAnchor: (FamixStSourceTextAnchor source: 'This is a comment');
		             commentedEntity: (self targetEntityNamed: 'Smalltalk.B3diff.c3()');
		             yourself.

	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.B3diff.c3()') and: (self targetEntityNamed: 'Smalltalk.B3diff.c3()').

	self assertRenameMatch: baseCmt to: targetCmt.
	self assertRenameMatch: targetCmt to: baseCmt
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchCommentNoMatch [
	"too much difference to be accepted (6 differences on a longer length of 22)
	6 / 22 = 0.27 (default tolerance is 0.20)"

	| baseCmt targetCmt |
	baseCmt := FamixStComment new
		           sourceAnchor: (FamixStSourceTextAnchor source: 'This is a comment');
		           commentedEntity: (self baseEntityNamed: 'Smalltalk.B3diff.c3()');
		           yourself.
	targetCmt := FamixStComment new
		             sourceAnchor: (FamixStSourceTextAnchor source: 'This is also another comment');
		             commentedEntity: (self targetEntityNamed: 'Smalltalk.B3diff.c3()');
		             yourself.

	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk.B3diff.c3()') and: (self targetEntityNamed: 'Smalltalk.B3diff.c3()').

	self denyRenameMatch: baseCmt to: targetCmt.
	self denyRenameMatch: targetCmt to: baseCmt
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchMethod [

	(self targetEntityNamed: 'Smalltalk.B3diff.c3()') name: 'x3'.
	"Note: does not change the mooseName, so we still look for it later using 'Smalltalk.B3diff.c3()'"
	(self targetEntityNamed: 'Smalltalk.B3diff.c3()') signature: 'x3()'.
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk.B3diff')
		and: (self targetEntityNamed: 'Smalltalk.B3diff').

	self
		assertRenameMatch: (self baseEntityNamed: 'Smalltalk.B3diff.c3()')
		to: (self targetEntityNamed: 'Smalltalk.B3diff.c3()').
	self
		assertRenameMatch: (self targetEntityNamed: 'Smalltalk.B3diff.c3()')
		to: (self baseEntityNamed: 'Smalltalk.B3diff.c3()')
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchPackage [

	(self targetEntityNamed: 'Famix-Diff-TestResource-P2') name:
		'Famix-Diff-TestResource-X0'.

	self
		assertRenameMatch: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		to: (self targetEntityNamed: 'Famix-Diff-TestResource-X0').
	self
		assertRenameMatch: (self targetEntityNamed: 'Famix-Diff-TestResource-X0')
		to: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchVariableMatching [
	"RenameMatching of variables depends on accesses
	 Create one access for the matching to happen"

	| var1 var2 |
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk.A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk.A3diff.c3()').

	var1 := self baseEntityNamed: 'Smalltalk.A3diff.c3().toto'.
	var2 := self targetEntityNamed: 'Smalltalk.A3diff.c3().var2'.

	FamixStAccess new
		variable: var1;
		accessor: (self baseEntityNamed: 'Smalltalk.A3diff.b3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk.A3diff.c3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk.A3diff.b3()').

	self assertRenameMatch: var1 to: var2.
	self assertRenameMatch: var2 to: var1
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchVariableNoMatch [
	"RnameMatching of variables depend on accesses
	 Here there is not enough (need at least 1)"

	| var1 var2 |
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk.A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk.A3diff.c3()').

	var1 := self baseEntityNamed: 'Smalltalk.A3diff.c3().toto'.
	var2 := self targetEntityNamed: 'Smalltalk.A3diff.c3().var2'.

	self denyRenameMatch: var1 to: var2.
	self denyRenameMatch: var2 to: var1
]
