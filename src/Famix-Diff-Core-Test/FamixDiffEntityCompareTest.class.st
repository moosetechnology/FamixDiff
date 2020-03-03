Class {
	#name : #FamixDiffEntityCompareTest,
	#superclass : #AbstractFamixDiffTest,
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffEntityCompareTest >> setUp [
	self model: (self importModelNamed: 'base' fromPackages: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3'))
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareAttributeAssociation [
	| ass1 att ass2 ass3 |
	ass1 := FAMIXAccess new.
	att := FAMIXAttribute new.
	self assert: (att comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: att).
	ass2 := FAMIXInvocation new.
	self assert: (att comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: att).
	ass3 := FAMIXReference new.
	self assert: (att comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: att)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareClassAssociation [
	| ass1 cl ass2 ass3 |
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	ass1 := cl incomingReferences first.
	self assert: (cl comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: cl).
	ass2 := cl outgoingInvocations first.
	self assert: (cl comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: cl).
	ass3 := cl incomingAccesses first.
	self assert: (cl comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: cl)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareClassAttribute [
	| att cl |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	self assert: (cl comeBeforeEntity: att ).
	self deny: (att comeBeforeEntity: cl)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareClassInheritance [
	| superClass subClass |
	superClass := self model entityNamed: 'Smalltalk::B4diff'.
	subClass := self model entityNamed: 'Smalltalk::A4diff'.
	self assert: (superClass comeBeforeEntity: subClass).
	self deny: (subClass comeBeforeEntity: superClass)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareClassMethod [
	| meth cl |
	meth := self model entityNamed: 'Smalltalk::A3diff.b3()'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	self assert: (cl comeBeforeEntity: meth ).
	self deny: (meth comeBeforeEntity: cl)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareMethodAssociation [
	| ass1 meth ass2 ass3 |
	ass1 := FAMIXAccess new.
	meth := FAMIXMethod new parentType: FAMIXClass new.
	self assert: (meth comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: meth).
	ass2 := FAMIXInvocation new.
	self assert: (meth comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: meth).
	ass3 := FAMIXReference new.
	self assert: (meth comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: meth)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareMethodAttribute [
	| att meth |
	att := self model entityNamed: 'Smalltalk::B3diff.att1'.
	meth := self model entityNamed: 'Smalltalk::A3diff.b3()'.
	
	"There is no container relation between att and meth, so it is the mooseName that is taken into account"
	self assert: (meth comeBeforeEntity: att ).
	self deny: (att comeBeforeEntity: meth).
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareScopingEntityAssociation [
	| ass1 ns ass2 ass3 pkg |
	ass1 := FAMIXAccess new.
	ns := FAMIXNamespace new.
	self assert: (ns comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: ns).
	ass2 := FAMIXInvocation new.
	self assert: (ns comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: ns).
	ass3 := FAMIXReference new.
	self assert: (ns comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: ns).
	pkg := FAMIXPackage new.
	self assert: (pkg comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: pkg).
	self assert: (pkg comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: pkg).
	self assert: (pkg comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: pkg)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareScopingEntityAttribute [
	| ns att pkg |
	pkg := (self model entityNamed: 'Moose-TestResources-ModelDiff-P3') name: 'Toto'.
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	self assert: (pkg comeBeforeEntity: att).
	self deny: (att comeBeforeEntity: pkg).
	ns := self model entityNamed: 'Smalltalk'.
	self assert: (ns comeBeforeEntity: att).
	self deny: (att comeBeforeEntity: ns)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareScopingEntityAttribute2 [
	| ns att pkg  |
	pkg := (self model entityNamed: 'Moose-TestResources-ModelDiff-P3') name: 'Toto'.
	att := self model entityNamed: 'Smalltalk::A4diff.att1'.
	self assert: (pkg comeBeforeEntity: att).
	self deny: (att comeBeforeEntity: pkg).
	
	ns := self model entityNamed: 'Smalltalk'.
	self assert: (ns comeBeforeEntity: att).
	self deny: (att comeBeforeEntity: ns).
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareScopingEntityClass [
	| ns cl pkg  |
	pkg := (self model entityNamed: 'Moose-TestResources-ModelDiff-P3') name: 'Toto'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	self assert: (pkg comeBeforeEntity: cl).
	self deny: (cl comeBeforeEntity: pkg).
	
	ns := self model entityNamed: 'Smalltalk'.
	self assert: (ns comeBeforeEntity: cl).
	self deny: (cl comeBeforeEntity: ns).
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareScopingEntityClass2 [
	| ns cl pkg |
	pkg := (self model entityNamed: 'Moose-TestResources-ModelDiff-P3') name: 'Toto'.
	cl := self model entityNamed: 'Smalltalk::A4diff'.
	self assert: (pkg comeBeforeEntity: cl).
	self deny: (cl comeBeforeEntity: pkg).
	
	ns := self model entityNamed: 'Smalltalk'.
	self assert: (ns comeBeforeEntity: cl).
	self deny: (cl comeBeforeEntity: ns)
]

{ #category : #tests }
FamixDiffEntityCompareTest >> testCompareScopingEntityMethod [
	| ns meth pkg |
	pkg := FAMIXPackage new.
	meth := FAMIXMethod new parentType: FAMIXClass new.
	self assert: (pkg comeBeforeEntity: meth).
	self deny: (meth comeBeforeEntity: pkg).
	ns := FAMIXNamespace new.
	self assert: (ns comeBeforeEntity: meth).
	self deny: (meth comeBeforeEntity: ns)
]
