Class {
	#name : #FamixDiffEntitiesMoveTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Test'
}

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchClass [
	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		createChg: FamixAddChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P2').	"changing package of A3 in target model"
	(snapshot targetModel entityNamed: 'Smalltalk::A3diff')
		parentPackage: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				moveMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				moveMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges
				tolerance: 0)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchMethod [
	"moving c3 metod"

	(snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()')
		parentType: (snapshot targetModel entityNamed: 'Smalltalk::A2diff').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				moveMatch: (snapshot targetModel entityNamed: 'Smalltalk::A2diff.c3()')
				givenChanges: testChanges
				tolerance: 0).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A2diff.c3()')
				moveMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges
				tolerance: 0)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchStub [
	| basA3 tgtA3 basA3c3 tgtA3c3 |
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'.
	self
		assert: (basA3c3 moveMatch: tgtA3c3 givenChanges: testChanges tolerance: 0).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self
		deny: (basA3c3 moveMatch: tgtA3c3 givenChanges: testChanges tolerance: 0).
	self
		assert: (basA3 moveMatch: tgtA3 givenChanges: testChanges tolerance: 0).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self
		deny: (basA3 moveMatch: tgtA3 givenChanges: testChanges tolerance: 0)
]

{ #category : #tests }
FamixDiffEntitiesMoveTest >> testMoveMatchVariable [
	| var1 var2 |
	"creating fake accesses because maching of variables depend on them
	 First we don't create enough accesses (need at least 3)"
	var1 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto'.
	FAMIXAccess new
		variable: var1;
		accessor: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.b3()').
	var2 := snapshot targetModel
		entityNamed: 'Smalltalk::B3diff.c3().toto'.
	FAMIXAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	FAMIXAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.b3()').
	self
		deny: (var1 moveMatch: var2 givenChanges: testChanges tolerance: 0).
	self
		deny: (var2 moveMatch: var1 givenChanges: testChanges tolerance: 0).	"now create one more access"

	FAMIXAccess new
		variable: var1;
		accessor: (snapshot baseModel entityNamed: 'Smalltalk::B3diff.c3()').
	FAMIXAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()').
	self
		assert: (var1 moveMatch: var2 givenChanges: testChanges tolerance: 0).
	self
		assert: (var2 moveMatch: var1 givenChanges: testChanges tolerance: 0)
]
