Class {
	#name : #FamixDiffEntitiesMoveTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchClass [

	self
		createChg: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P2')
		and: (snapshot targetModel entityNamed: 'Famix-Diff-TestResource-P2').
	self createChg: FamixAddChange with: (snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P1'). "changing package of A3 in target model"
	(snapshot targetModel entityNamed: 'Smalltalk::A3diff') parentPackage: (snapshot targetModel entityNamed: 'Famix-Diff-TestResource-P1').
	self assert: ((snapshot baseModel entityNamed: 'Smalltalk::A3diff') moveMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff') resolver: resolver).
	self assert: ((snapshot targetModel entityNamed: 'Smalltalk::A3diff') moveMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff') resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchMethod [

	"moving c3 metod"

	(snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()') parentType: (snapshot targetModel entityNamed: 'Smalltalk::A2diff').
	self assert:
		((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()') moveMatch: (snapshot targetModel entityNamed: 'Smalltalk::A2diff.c3()') resolver: resolver).
	self assert:
		((snapshot targetModel entityNamed: 'Smalltalk::A2diff.c3()') moveMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()') resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchStub [

	| basA3 tgtA3 basA3c3 tgtA3c3 |
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'.
	self assert: (basA3c3 moveMatch: tgtA3c3 resolver: resolver).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 moveMatch: tgtA3c3 resolver: resolver).
	self assert: (basA3 moveMatch: tgtA3 resolver: resolver).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self deny: (basA3 moveMatch: tgtA3 resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchVariable [

	| var1 var2 |
	"creating fake accesses because maching of variables depend on them
	 First we don't create enough accesses (need at least 1)"
	var1 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto'.
	var2 := snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3().toto'.
	self deny: (var1 moveMatch: var2 resolver: resolver).
	self deny: (var2 moveMatch: var1 resolver: resolver). "now create one more access"

	FamixStAccess new
		variable: var1;
		accessor: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.b3()').
	FamixStAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	FamixStAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.b3()').

	self assert: (var1 moveMatch: var2 resolver: resolver).
	self assert: (var2 moveMatch: var1 resolver: resolver)
]
