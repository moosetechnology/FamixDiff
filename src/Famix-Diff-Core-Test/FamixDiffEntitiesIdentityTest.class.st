Class {
	#name : #FamixDiffEntitiesIdentityTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassNot [
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		createChg: FamixAddChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P2').

	"tests"
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A2diff')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A2diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassNotPackageDifferent [
	"setup: create changes for parents"

	self
		createChg: FamixAddChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P2').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P4').

	"classes with same name but different packages"
	snapshot targetModel
		add:
			(FAMIXClass new
				name: 'A4diff';
				parentPackage: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2');
				container: (snapshot targetModel entityNamed: 'Smalltalk')).
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A4diff')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A4diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassParentIsNil [
	"classes with same name but different packages"

	snapshot targetModel add: (FAMIXClass new name: 'A4diff').
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				identityMatch: (snapshot targetModel entityNamed: 'A4diff')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'A4diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A4diff')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassSame [
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
		and: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchMethod [
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff').
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.b2()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.b3()')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchPackage [
	self
		assert:
			((snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				identityMatch: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				identityMatch: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges).
	self
		deny:
			((snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				identityMatch: (snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Moose-TestResources-ModelDiff-P2')
				identityMatch: (snapshot baseModel entityNamed: 'Moose-TestResources-ModelDiff-P3')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchStubs [
	| basP3 tgtP3 basA3 tgtA3 basA3c3 tgtA3c3 tgtB3c3 basA3c3toto tgtA3c3toto |
	basP3 := snapshot baseModel
		entityNamed: 'Moose-TestResources-ModelDiff-P3'.
	tgtP3 := snapshot targetModel
		entityNamed: 'Moose-TestResources-ModelDiff-P3'.
	basA3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff'.
	tgtA3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff'.
	basA3c3 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()'.
	tgtB3c3 := snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()'.
	basA3c3toto := snapshot baseModel
		entityNamed: 'Smalltalk::A3diff.c3().toto'.
	tgtA3c3toto := snapshot targetModel
		entityNamed: 'Smalltalk::A3diff.c3().toto'.
	basP3 isStub: true.
	tgtP3 isStub: true.
	basA3 isStub: true.
	tgtA3 isStub: true.
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	tgtB3c3 isStub: true.
	basA3c3toto isStub: true.
	tgtA3c3toto isStub: true.
	self assert: (basP3 identityMatch: tgtP3 givenChanges: testChanges).
	self createChg: FamixVersionChange with: basP3 and: tgtP3.
	self assert: (basA3 identityMatch: tgtA3 givenChanges: testChanges).
	self createChg: FamixVersionChange with: basA3 and: tgtA3.
	self
		assert: (basA3c3 identityMatch: tgtA3c3 givenChanges: testChanges).
	self deny: (basA3c3 identityMatch: tgtB3c3 givenChanges: testChanges).
	self createChg: FamixVersionChange with: basA3c3 and: tgtA3c3.
	self
		assert: (basA3c3toto identityMatch: tgtA3c3toto givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchVariable [
	"setup: create changes for parents"

	self
		createChg: FamixVersionChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3()')
		and: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	self
		createChg: FamixRemovalChange
		with: (snapshot baseModel entityNamed: 'Smalltalk::A4diff').

	"testing variable 'toto'"
	self
		assert:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges).
	self
		assert:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges).

	"testing variable 'toto' against 'var2'"
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().var2')
				givenChanges: testChanges).
	self
		deny:
			((snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3().var2')
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges).

	"testing variables 'toto'"
	self
		deny:
			((snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				identityMatch:
					(FAMIXLocalVariable new
						name: 'toto';
						parentBehaviouralEntity: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()');
						yourself)
				givenChanges: testChanges).
	self
		deny:
			((FAMIXLocalVariable new
				name: 'toto';
				parentBehaviouralEntity: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()');
				yourself)
				identityMatch: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto')
				givenChanges: testChanges)
]
