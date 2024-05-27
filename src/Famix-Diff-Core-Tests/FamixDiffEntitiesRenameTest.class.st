Class {
	#name : #FamixDiffEntitiesRenameTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchClass [

	(snapshot targetModel entityNamed: 'Smalltalk::A3diff') name: 'X3diff'.
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P2')
		and: (snapshot targetModel entityNamed: 'Famix-Diff-TestResource-P2').
	self assert: ((snapshot baseModel entityNamed: 'Smalltalk::A3diff') renameMatch: (snapshot targetModel entityNamed: 'Smalltalk::X3diff') resolver: resolver).
	self assert: ((snapshot targetModel entityNamed: 'Smalltalk::X3diff') renameMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff') resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchMethod [

	(snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()') name: 'x3'.
	"Note: does not change the mooseName, so we still look for it later using 'Smalltalk::B3diff.c3()'"
	(snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()') signature: 'x3()'.
	self createChange: FamixUnchangedChange with: (snapshot baseModel entityNamed: 'Smalltalk::B3diff') and: (snapshot targetModel entityNamed: 'Smalltalk::B3diff').
	self assert:
		((snapshot baseModel entityNamed: 'Smalltalk::B3diff.c3()') renameMatch: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()') resolver: resolver).
	self assert:
		((snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()') renameMatch: (snapshot baseModel entityNamed: 'Smalltalk::B3diff.c3()') resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchPackage [

	(snapshot targetModel entityNamed: 'Famix-Diff-TestResource-P2') name: 'Famix-Diff-TestResource-X0'.
	self assert:
		((snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P2')
			 renameMatch: (snapshot targetModel entityNamed: 'Famix-Diff-TestResource-X0')
			 resolver: resolver).
	self assert:
		((snapshot targetModel entityNamed: 'Famix-Diff-TestResource-X0')
			 renameMatch: (snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P2')
			 resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchStub [

	| basA3 tgtA3 basA3c3 tgtA3c3 basP3 tgtP3 |
	basP3 := snapshot baseModel entityNamed: 'Famix-Diff-TestResource-P2'.
	tgtP3 := snapshot targetModel entityNamed: 'Famix-Diff-TestResource-P2'.
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'. "self assert: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 renameMatch: tgtA3c3 givenChanges: testChanges)."
	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	tgtA3 name: 'X3'.
	self assert: (basA3 renameMatch: tgtA3 resolver: resolver).
	basA3 isStub: true.
	tgtA3 isStub: true.
	self deny: (basA3 renameMatch: tgtA3 resolver: resolver).
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	tgtA3c3 name: 'x3'.
	tgtA3c3 signature: 'x3()'.
	self assert: (basA3c3 renameMatch: tgtA3c3 resolver: resolver).
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	self deny: (basA3c3 renameMatch: tgtA3c3 resolver: resolver)
]

{ #category : #tests }
FamixDiffEntitiesRenameTest >> testRenameMatchVariable [

	| var1 var2 |
	self
		createChange: FamixUnchangedChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'). "creating fake accesses because maching of variables depends on them
	 First we don't create enough accesses (need at least 1)"
	var1 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto'.
	var2 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().var2'.
	self deny: (var1 renameMatch: var2 resolver: resolver).
	self deny: (var2 renameMatch: var1 resolver: resolver). "now create one more access"

	FamixStAccess new
		variable: var1;
		accessor: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.b3()').
	FamixStAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	FamixStAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.b3()').
	self assert: (var1 renameMatch: var2 resolver: resolver).
	self assert: (var2 renameMatch: var1 resolver: resolver)
]
