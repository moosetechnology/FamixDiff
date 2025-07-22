Class {
	#name : 'FamixDiffStubEntitiesMoveTest',
	#superclass : 'AbstractFamixDiffWithModelTest',
	#instVars : [
		'basA3',
		'tgtA3',
		'basA3c3',
		'tgtA3c3'
	],
	#category : 'Famix-Diff-Core-Tests',
	#package : 'Famix-Diff-Core-Tests'
}

{ #category : 'running' }
FamixDiffStubEntitiesMoveTest >> setUp [

	super setUp.

	basA3 := self baseEntityNamed: 'Smalltalk.A3diff'.
	tgtA3 := self targetEntityNamed: 'Smalltalk.A3diff'.
	basA3c3 := self baseEntityNamed: 'Smalltalk.A3diff.c3()'.
	tgtA3c3 := self targetEntityNamed: 'Smalltalk.A3diff.c3()'.
]

{ #category : 'tests' }
FamixDiffStubEntitiesMoveTest >> testMoveMatchStubClass [

	self assertMoveMatch: basA3 to: tgtA3.

	basA3 isStub: true.
	tgtA3 isStub: true.

	self denyMoveMatch: basA3 to: tgtA3
]

{ #category : 'tests' }
FamixDiffStubEntitiesMoveTest >> testMoveMatchStubMethod [

	self assertMoveMatch: basA3c3 to: tgtA3c3.

	basA3c3 isStub: true.
	tgtA3c3 isStub: true.

	self denyMoveMatch: basA3c3 to: tgtA3c3
]
