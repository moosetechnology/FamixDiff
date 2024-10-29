Class {
	#name : #FamixDiffStubEntitiesIdentityTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#instVars : [
		'basP3',
		'tgtP3',
		'basA3',
		'tgtA3',
		'basA3c3',
		'tgtA3c3',
		'tgtB3c3',
		'basA3c3toto',
		'tgtA3c3toto'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
FamixDiffStubEntitiesIdentityTest >> setUp [
	super setUp.

	basP3 := (self baseEntityNamed: 'Famix-Diff-TestResource-P2') isStub: true ; yourself.
	tgtP3 := (self targetEntityNamed: 'Famix-Diff-TestResource-P2') isStub: true ; yourself.
	basA3 := (self baseEntityNamed: 'Smalltalk::A3diff') isStub: true ; yourself.
	tgtA3 := (self targetEntityNamed: 'Smalltalk::A3diff') isStub: true ; yourself.
	basA3c3 := (self baseEntityNamed: 'Smalltalk::A3diff.c3()') isStub: true ; yourself.
	tgtA3c3 := (self targetEntityNamed: 'Smalltalk::A3diff.c3()') isStub: true ; yourself.
	tgtB3c3 := (self targetEntityNamed: 'Smalltalk::B3diff.c3()') isStub: true ; yourself.
	basA3c3toto := (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto') isStub: true ; yourself.
	tgtA3c3toto := (self targetEntityNamed: 'Smalltalk::A3diff.c3().toto') isStub: true ; yourself.

]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsClassMatching [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self assertIdentityMatch: basA3 to: tgtA3
]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsLocalVariableSameName [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	self createChange: FamixUnchangedChange with: basA3c3 and: tgtA3c3.

	self assertIdentityMatch: basA3c3toto to: tgtA3c3toto.
	self
		assertIdentityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3().toto')
		to: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsMethodMatching [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.

	self assertIdentityMatch: basA3c3 to: tgtA3c3
]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsMethodsNoMatch [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.

	self denyIdentityMatch: basA3c3 to: tgtB3c3
]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsPackageMatching [

	self assertIdentityMatch: basP3 to: tgtP3
]
