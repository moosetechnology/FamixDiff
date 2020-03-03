Class {
	#name : #FamixDiffWithFilterTest,
	#superclass : #FamixDiffTest,
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffWithFilterTest >> setUp [ 
	snapshot := FamixDiffWithFilter new.
]

{ #category : #tests }
FamixDiffWithFilterTest >> testInFilteredPackageEmpty [
	<expectedFailure>
	self flag: 'VB: I do not understand the goal of the tested class...'.
	snapshot base: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3' #'Moose-TestResources-ModelDiff-P4' )).
	
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Moose-TestResources-ModelDiff-P3')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff.c3()')).
]

{ #category : #tests }
FamixDiffWithFilterTest >> testInFilteredPackageFilterCollection [
	<expectedFailure>
	self flag: 'VB: I do not understand the goal of the tested class...'.
	snapshot base: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3' #'Moose-TestResources-ModelDiff-P4')).
	snapshot pckgFilter: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3').
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Moose-TestResources-ModelDiff-P3')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff.c3()')).
	self deny: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Moose-TestResources-ModelDiff-P4')).
	self deny: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A4diff')).
	self deny: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A4diff.b3()'))
]

{ #category : #tests }
FamixDiffWithFilterTest >> testInFilteredPackageOneFilter [
	<expectedFailure>
	self flag: 'VB: I do not understand the goal of the tested class...'.
	snapshot base: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3' #'Moose-TestResources-ModelDiff-P4')).
	snapshot pckgFilter: 'Moose-TestResources-ModelDiff-P3'.
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Moose-TestResources-ModelDiff-P3')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff.c3()')).
	self deny: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Moose-TestResources-ModelDiff-P4')).
	self deny: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A4diff')).
	self deny: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A4diff.b3()'))
]
