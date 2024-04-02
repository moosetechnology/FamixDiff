Class {
	#name : #FamixDiffQuasiEqualTest,
	#superclass : #TestCase,
	#instVars : [
		'typ1',
		'typ2',
		'resolver'
	],
	#category : #'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffQuasiEqualTest >> attNamed: aString inClass: aFmxType [
	^ (FAMIXAttribute named: aString)
		parentType: aFmxType;
		yourself
]

{ #category : #running }
FamixDiffQuasiEqualTest >> methNamed: aString inClass: aFmxType [
	^ (FAMIXMethod named: aString)
		parentType: aFmxType;
		yourself
]

{ #category : #running }
FamixDiffQuasiEqualTest >> setUp [

	typ1 := self typeNamed: 'AClass'.
	self attNamed: 'att-A' inClass: typ1.
	self methNamed: 'meth-A' inClass: typ1.

	typ2 := self typeNamed: 'AClass'.
	self attNamed: 'att-A' inClass: typ2.
	self methNamed: 'meth-A' inClass: typ2.

	resolver := FamixDiffResolver new.
	resolver orchestrator: FXDiff new
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testType33Percent [

	self attNamed: 'att-B' inClass: typ1.
	self attNamed: 'att-C' inClass: typ2.

	resolver tolerance: 1.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.5.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.34.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.
	self deny: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self deny: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver)
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testType50Percent [

	self attNamed: 'att-B' inClass: typ1.
	self methNamed: 'meth-B' inClass: typ1.

	self attNamed: 'att-C' inClass: typ2.
	self methNamed: 'meth-C' inClass: typ2.

	resolver tolerance: 1.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.5.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.4.
	self deny: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self deny: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.
	self deny: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self deny: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver)
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testTypeDifferent [

	| typ3 |
	typ3 := self typeNamed: 'AClass'.

	self attNamed: 'att-B' inClass: typ1.

	self attNamed: 'att-C' inClass: typ3.
	self attNamed: 'att-D' inClass: typ3.
	self methNamed: 'meth-C' inClass: typ3.

	resolver tolerance: 1.
	self assert: (typ1 hasEqualContentAndDependencies: typ3 resolver: resolver).
	self assert: (typ3 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.9.
	self deny: (typ1 hasEqualContentAndDependencies: typ3 resolver: resolver).
	self deny: (typ3 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.
	self deny: (typ1 hasEqualContentAndDependencies: typ3 resolver: resolver).
	self deny: (typ3 hasEqualContentAndDependencies: typ1 resolver: resolver)
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testTypeEquals [

	self attNamed: 'att-B' inClass: typ1.
	self methNamed: 'meth-B' inClass: typ1.

	self attNamed: 'att-B' inClass: typ2.
	self methNamed: 'meth-B' inClass: typ2.

	resolver tolerance: 1.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.5.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver).

	resolver tolerance: 0.
	self assert: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self assert: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver)
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testTypeNotEnoughMembers [

	typ1 := self typeNamed: 'AClass'.
	typ2 := self typeNamed: 'AClass'.
	self deny: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self deny: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver)
]

{ #category : #running }
FamixDiffQuasiEqualTest >> typeNamed: aString [
	^ FAMIXType named: aString
]
