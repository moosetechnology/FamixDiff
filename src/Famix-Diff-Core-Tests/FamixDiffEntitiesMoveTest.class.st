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
	self createChange: FamixAddChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P1'). "changing package of A3 in target model"
	(self targetEntityNamed: 'Smalltalk::A3diff') parentPackage: (self targetEntityNamed: 'Famix-Diff-TestResource-P1').
	self assert: ((self baseEntityNamed: 'Smalltalk::A3diff') moveMatch: (self targetEntityNamed: 'Smalltalk::A3diff') resolver: self resolver).
	self assert: ((self targetEntityNamed: 'Smalltalk::A3diff') moveMatch: (self baseEntityNamed: 'Smalltalk::A3diff') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchMethod [
	"moving c3 metod"

	(self targetEntityNamed: 'Smalltalk::A3diff.c3()') parentType: (self targetEntityNamed: 'Smalltalk::A2diff').
	self assert:
		((self baseEntityNamed: 'Smalltalk::A3diff.c3()') moveMatch: (self targetEntityNamed: 'Smalltalk::A2diff.c3()') resolver: self resolver).
	self assert:
		((self targetEntityNamed: 'Smalltalk::A2diff.c3()') moveMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchStub [

	| basA3 tgtA3 basA3c3 tgtA3c3 |
	basA3 := self baseEntityNamed: 'Smalltalk::A3diff'.
	tgtA3 := self targetEntityNamed: 'Smalltalk::A3diff'.
	basA3c3 := self baseEntityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := self targetEntityNamed: 'Smalltalk::A3diff.c3()'.
	self assert: (basA3c3 moveMatch: tgtA3c3 resolver: self resolver).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 moveMatch: tgtA3c3 resolver: self resolver).
	self assert: (basA3 moveMatch: tgtA3 resolver: self resolver).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self deny: (basA3 moveMatch: tgtA3 resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchVariable [

	| var1 var2 |
	"creating fake accesses because maching of variables depend on them
	 First we don't create enough accesses (need at least 1)"
	var1 := self baseEntityNamed: 'Smalltalk::A3diff.c3().toto'.
	var2 := self targetEntityNamed: 'Smalltalk::B3diff.c3().toto'.
	self deny: (var1 moveMatch: var2 resolver: self resolver).
	self deny: (var2 moveMatch: var1 resolver: self resolver). "now create one more access"

	FamixStAccess new
		variable: var1;
		accessor: (self baseEntityNamed: 'Smalltalk::A3diff.b3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	FamixStAccess new
		variable: var2;
		accessor: (self targetEntityNamed: 'Smalltalk::A3diff.b3()').

	self assert: (var1 moveMatch: var2 resolver: self resolver).
	self assert: (var2 moveMatch: var1 resolver: self resolver)
]
