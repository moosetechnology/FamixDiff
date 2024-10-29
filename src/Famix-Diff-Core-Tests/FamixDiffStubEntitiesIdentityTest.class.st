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
	self assert: (basA3 identityMatch: tgtA3 resolver: self resolver).

]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsLocalVariableSameName [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	self createChange: FamixUnchangedChange with: basA3c3 and: tgtA3c3.

	self assert: (basA3c3toto identityMatch: tgtA3c3toto resolver: self resolver).
	self assert:
		((self targetEntityNamed: 'Smalltalk::A3diff.c3().toto')
			identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			resolver: self resolver)
]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsMethodMatching [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	self assert: (basA3c3 identityMatch: tgtA3c3 resolver: self resolver).

]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsMethodsNoMatch [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.

	self deny: (basA3c3 identityMatch: tgtB3c3 resolver: self resolver).

]

{ #category : #tests }
FamixDiffStubEntitiesIdentityTest >> testIdentityMatchStubsPackageMatching [

	self assert: (basP3 identityMatch: tgtP3 resolver: self resolver).

]
