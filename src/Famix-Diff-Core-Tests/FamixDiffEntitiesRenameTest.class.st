Class {
	#name : #FamixDiffEntitiesRenameTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchClass [

	(self targetEntityNamed: 'Smalltalk::A3diff') name: 'X3diff'.
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self assert: ((self baseEntityNamed: 'Smalltalk::A3diff') renameMatch: (self targetEntityNamed: 'Smalltalk::X3diff') resolver: self resolver).
	self assert: ((self targetEntityNamed: 'Smalltalk::X3diff') renameMatch: (self baseEntityNamed: 'Smalltalk::A3diff') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchMethod [

	(self targetEntityNamed: 'Smalltalk::B3diff.c3()') name: 'x3'.
	"Note: does not change the mooseName, so we still look for it later using 'Smalltalk::B3diff.c3()'"
	(self targetEntityNamed: 'Smalltalk::B3diff.c3()') signature: 'x3()'.
	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk::B3diff') and: (self targetEntityNamed: 'Smalltalk::B3diff').
	self assert:
		((self baseEntityNamed: 'Smalltalk::B3diff.c3()') renameMatch: (self targetEntityNamed: 'Smalltalk::B3diff.c3()') resolver: self resolver).
	self assert:
		((self targetEntityNamed: 'Smalltalk::B3diff.c3()') renameMatch: (self baseEntityNamed: 'Smalltalk::B3diff.c3()') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchPackage [

	(self targetEntityNamed: 'Famix-Diff-TestResource-P2') name: 'Famix-Diff-TestResource-X0'.
	self assert:
		((self baseEntityNamed: 'Famix-Diff-TestResource-P2') renameMatch: (self targetEntityNamed: 'Famix-Diff-TestResource-X0') resolver: self resolver).
	self assert:
		((self targetEntityNamed: 'Famix-Diff-TestResource-X0') renameMatch: (self baseEntityNamed: 'Famix-Diff-TestResource-P2') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchStub [

	| basA3 tgtA3 basA3c3 tgtA3c3 basP3 tgtP3 |
	basP3 := self baseEntityNamed: 'Famix-Diff-TestResource-P2'.
	tgtP3 := self targetEntityNamed: 'Famix-Diff-TestResource-P2'.
	basA3 := self baseEntityNamed: 'Smalltalk::A3diff'.
	tgtA3 := self targetEntityNamed: 'Smalltalk::A3diff'.
	basA3c3 := self baseEntityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := self targetEntityNamed: 'Smalltalk::A3diff.c3()'. "self assert: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges)."
	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	tgtA3 name: 'X3'.
	self assert: (basA3 renameMatch: tgtA3 resolver: self resolver).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self deny: (basA3 renameMatch: tgtA3 resolver: self resolver).
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	tgtA3c3 name: 'x3'.
	tgtA3c3 signature: 'x3()'.
	self assert: (basA3c3 renameMatch: tgtA3c3 resolver: self resolver).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 renameMatch: tgtA3c3 resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchVariable [

	| var1 var2 |
	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::A3diff.c3()'). "creating fake accesses because maching of variables depends on them
	 First we don't create enough accesses (need at least 1)"
	var1 := self baseEntityNamed: 'Smalltalk::A3diff.c3().toto'.
	var2 := self targetEntityNamed: 'Smalltalk::A3diff.c3().var2'.
	self deny: (var1 renameMatch: var2 resolver: self resolver).
	self deny: (var2 renameMatch: var1 resolver: self resolver). "now create one more access"

	FamixStAccess new
		variable: var1;
		accessor: (self baseEntityNamed: 'Smalltalk::A3diff.b3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk::A3diff.b3()').
	self assert: (var1 renameMatch: var2 resolver: self resolver).
	self assert: (var2 renameMatch: var1 resolver: self resolver)
]
