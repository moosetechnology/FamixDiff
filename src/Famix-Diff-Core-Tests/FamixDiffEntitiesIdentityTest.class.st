Class {
	#name : #FamixDiffEntitiesIdentityTest,
	#superclass : #AbstractFamixDiffWithModelTest,
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassNot [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self createChange: FamixAddChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P1').

	"tests"
	self deny: ((self baseEntityNamed: 'Smalltalk::A3diff') identityMatch: (self targetEntityNamed: 'Smalltalk::A2diff') resolver: self resolver).
	self deny: ((self targetEntityNamed: 'Smalltalk::A2diff') identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassNotPackageDifferent [
	"setup: create changes for parents"

	self createChange: FamixAddChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P1').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Famix-Diff-TestResource-P3').

	"classes with same name but different packages"
	diff targetModel add: (FamixStClass new
			 name: 'A4diff';
			 parentPackage: (self targetEntityNamed: 'Famix-Diff-TestResource-P1');
			 typeContainer: (self targetEntityNamed: 'Smalltalk')).
	self deny: ((self baseEntityNamed: 'Smalltalk::A4diff') identityMatch: (self targetEntityNamed: 'Smalltalk::A4diff') resolver: self resolver).
	self deny: ((self targetEntityNamed: 'Smalltalk::A4diff') identityMatch: (self baseEntityNamed: 'Smalltalk::A4diff') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassParentIsNil [
	"classes with same name but different packages"

	diff targetModel add: (FamixStClass new name: 'A4diff').
	self deny: ((self baseEntityNamed: 'Smalltalk::A4diff') identityMatch: (self targetEntityNamed: 'A4diff') resolver: self resolver).
	self deny: ((self targetEntityNamed: 'A4diff') identityMatch: (self baseEntityNamed: 'Smalltalk::A4diff') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchClassSame [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
		and: (self targetEntityNamed: 'Famix-Diff-TestResource-P2').
	self assert: ((self baseEntityNamed: 'Smalltalk::A3diff') identityMatch: (self targetEntityNamed: 'Smalltalk::A3diff') resolver: self resolver).
	self assert: ((self targetEntityNamed: 'Smalltalk::A3diff') identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchMethod [
	"setup: create changes for parents"

	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk::A3diff') and: (self targetEntityNamed: 'Smalltalk::A3diff').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk::A4diff').
	self assert:
		((self baseEntityNamed: 'Smalltalk::A3diff.c3()') identityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3()') resolver: self resolver).
	self assert:
		((self targetEntityNamed: 'Smalltalk::A3diff.c3()') identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()') resolver: self resolver).
	self deny:
		((self baseEntityNamed: 'Smalltalk::A3diff.c3()') identityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.b2()') resolver: self resolver).
	self deny:
		((self targetEntityNamed: 'Smalltalk::A3diff.b3()') identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()') resolver: self resolver).
	self deny:
		((self baseEntityNamed: 'Smalltalk::A3diff.c3()') identityMatch: (self targetEntityNamed: 'Smalltalk::B3diff.c3()') resolver: self resolver).
	self deny:
		((self targetEntityNamed: 'Smalltalk::B3diff.c3()') identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3()') resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchPackage [

	self assert:
		((self baseEntityNamed: 'Famix-Diff-TestResource-P2')
			 identityMatch: (self targetEntityNamed: 'Famix-Diff-TestResource-P2')
			 resolver: self resolver).
	self assert:
		((self targetEntityNamed: 'Famix-Diff-TestResource-P2')
			 identityMatch: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
			 resolver: self resolver).
	self deny:
		((self baseEntityNamed: 'Famix-Diff-TestResource-P2')
			 identityMatch: (self targetEntityNamed: 'Famix-Diff-TestResource-P1')
			 resolver: self resolver).
	self deny:
		((self targetEntityNamed: 'Famix-Diff-TestResource-P1')
			 identityMatch: (self baseEntityNamed: 'Famix-Diff-TestResource-P2')
			 resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchStubs [

	| basP3 tgtP3 basA3 tgtA3 basA3c3 tgtA3c3 tgtB3c3 basA3c3toto tgtA3c3toto |
	basP3 := self baseEntityNamed: 'Famix-Diff-TestResource-P2'.
	tgtP3 := self targetEntityNamed: 'Famix-Diff-TestResource-P2'.
	basA3 := self baseEntityNamed: 'Smalltalk::A3diff'.
	tgtA3 := self targetEntityNamed: 'Smalltalk::A3diff'.
	basA3c3 := self baseEntityNamed: 'Smalltalk::A3diff.c3()'.
	tgtA3c3 := self targetEntityNamed: 'Smalltalk::A3diff.c3()'.
	tgtB3c3 := self targetEntityNamed: 'Smalltalk::B3diff.c3()'.
	basA3c3toto := self baseEntityNamed: 'Smalltalk::A3diff.c3().toto'.
	tgtA3c3toto := self targetEntityNamed: 'Smalltalk::A3diff.c3().toto'.
	basP3 isStub: true.
	tgtP3 isStub: true.
	basA3 isStub: true.
	tgtA3 isStub: true.
	basA3c3 isStub: true.
	tgtA3c3 isStub: true.
	tgtB3c3 isStub: true.
	basA3c3toto isStub: true.
	tgtA3c3toto isStub: true.
	self assert: (basP3 identityMatch: tgtP3 resolver: self resolver).
	self createChange: FamixUnchangedChange with: basP3 and: tgtP3.
	self assert: (basA3 identityMatch: tgtA3 resolver: self resolver).
	self createChange: FamixUnchangedChange with: basA3 and: tgtA3.
	self assert: (basA3c3 identityMatch: tgtA3c3 resolver: self resolver).
	self deny: (basA3c3 identityMatch: tgtB3c3 resolver: self resolver).
	self createChange: FamixUnchangedChange with: basA3c3 and: tgtA3c3.
	self assert: (basA3c3toto identityMatch: tgtA3c3toto resolver: self resolver).
	self assert: ((self targetEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 resolver: self resolver)
]

{ #category : #tests }
FamixDiffEntitiesIdentityTest >> testIdentityMatchVariable [
	"setup: create changes for parents"

	self
		createChange: FamixUnchangedChange
		with: (self baseEntityNamed: 'Smalltalk::A3diff.c3()')
		and: (self targetEntityNamed: 'Smalltalk::A3diff.c3()').
	self createChange: FamixRemovalChange with: (self baseEntityNamed: 'Smalltalk::A4diff').

	"testing variable 'toto'"
	self assert: ((self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 identityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 resolver: self resolver).
	self assert: ((self targetEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 resolver: self resolver).

	"testing variable 'toto' against 'var2'"
	self deny: ((self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 identityMatch: (self targetEntityNamed: 'Smalltalk::A3diff.c3().var2')
			 resolver: self resolver).
	self deny: ((self targetEntityNamed: 'Smalltalk::A3diff.c3().var2')
			 identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 resolver: self resolver).

	"testing variables 'toto'"
	self deny: ((self baseEntityNamed: 'Smalltalk::A3diff.c3().toto')
			 identityMatch: (FamixStLocalVariable new
					  name: 'toto';
					  parentBehaviouralEntity: (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
					  yourself)
			 resolver: self resolver).
	self deny: ((FamixStLocalVariable new
			  name: 'toto';
			  parentBehaviouralEntity: (self targetEntityNamed: 'Smalltalk::B3diff.c3()');
			  yourself) identityMatch: (self baseEntityNamed: 'Smalltalk::A3diff.c3().toto') resolver: self resolver)
]
