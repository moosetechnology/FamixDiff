Class {
	#name : #FamixDiffStubEntitiesRenameTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#instVars : [
		'basP3',
		'tgtP3',
		'basA3',
		'tgtA3',
		'basA3c3',
		'tgtA3c3'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
FamixDiffStubEntitiesRenameTest >> setUp [

	super setUp.

	basP3 := self baseEntityNamed: 'Famix-Diff-TestResource-P2'.
	tgtP3 := self targetEntityNamed: 'Famix-Diff-TestResource-P2'.
	basA3 := self baseEntityNamed: 'Smalltalk::A3diff'.
	tgtA3 := self targetEntityNamed: 'Smalltalk::A3diff'.
	basA3c3 := self baseEntityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := self targetEntityNamed: 'Smalltalk::A3diff.c3()'.
]

{ #category : #tests }
FamixDiffStubEntitiesRenameTest >> testRenameMatchStubMatching [

	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	tgtA3 name: 'X3'.

	self assertRenameMatch: basA3 to: tgtA3
]

{ #category : #tests }
FamixDiffStubEntitiesRenameTest >> testRenameMatchStubMethodMatching [

	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	basA3 isStub: true.
	tgtA3 isStub: true.
	tgtA3c3 name: 'x3'.
	tgtA3c3 signature: 'x3()'.

	self assertRenameMatch: basA3c3 to: tgtA3c3
]

{ #category : #tests }
FamixDiffStubEntitiesRenameTest >> testRenameMatchStubMethodNoMatch [

	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	basA3 isStub: true.
	tgtA3 isStub: true.
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	tgtA3c3 name: 'x3'.
	tgtA3c3 signature: 'x3()'.

	self denyRenameMatch: basA3c3 to: tgtA3c3
]
