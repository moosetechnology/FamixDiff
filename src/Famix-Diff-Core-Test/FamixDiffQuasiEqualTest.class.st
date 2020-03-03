Class {
	#name : #FamixDiffQuasiEqualTest,
	#superclass : #TestCase,
	#instVars : [
		'typ1',
		'typ2'
	],
	#category : 'Famix-Diff-Core-Test'
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
	self methNamed: 'meth-A' inClass: typ2
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testType33Percent [
	self attNamed: 'att-B' inClass: typ1.

	self attNamed: 'att-C' inClass: typ2.

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 1).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 1).

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 0.5).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 0.5).

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 0.34).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 0.34).

	self deny: (typ1 quasiEqualBody: typ2 tolerance: 0).
	self deny: (typ2 quasiEqualBody: typ1 tolerance: 0).

]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testType50Percent [
	self attNamed: 'att-B' inClass: typ1.
	self methNamed: 'meth-B' inClass: typ1.

	self attNamed: 'att-C' inClass: typ2.
	self methNamed: 'meth-C' inClass: typ2.

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 1).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 1).

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 0.5).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 0.5).

	self deny: (typ1 quasiEqualBody: typ2 tolerance: 0.4).
	self deny: (typ2 quasiEqualBody: typ1 tolerance: 0.4).

	self deny: (typ1 quasiEqualBody: typ2 tolerance: 0).
	self deny: (typ2 quasiEqualBody: typ1 tolerance: 0).

]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testTypeDifferent [
	| typ3 |

	typ3 := self typeNamed: 'AClass'.

	self attNamed: 'att-B' inClass: typ1.

	self attNamed: 'att-C' inClass: typ3.
	self attNamed: 'att-D' inClass: typ3.
	self methNamed: 'meth-C' inClass: typ3.

	self assert: (typ1 quasiEqualBody: typ3 tolerance: 1).
	self assert: (typ3 quasiEqualBody: typ1 tolerance: 1).

	self deny: (typ1 quasiEqualBody: typ3 tolerance: 0.9).
	self deny: (typ3 quasiEqualBody: typ1 tolerance: 0.9).

	self deny: (typ1 quasiEqualBody: typ3 tolerance: 0).
	self deny: (typ3 quasiEqualBody: typ1 tolerance: 0).

]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testTypeEquals [
	self attNamed: 'att-B' inClass: typ1.
	self methNamed: 'meth-B' inClass: typ1.

	self attNamed: 'att-B' inClass: typ2.
	self methNamed: 'meth-B' inClass: typ2.

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 1).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 1).

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 0.5).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 0.5).

	self assert: (typ1 quasiEqualBody: typ2 tolerance: 0).
	self assert: (typ2 quasiEqualBody: typ1 tolerance: 0).

]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testTypeNotEnoughMembers [
	self deny: (typ1 quasiEqualBody: typ2 tolerance: 1).
	self deny: (typ2 quasiEqualBody: typ1 tolerance: 1)
]

{ #category : #running }
FamixDiffQuasiEqualTest >> typeNamed: aString [
	^ FAMIXType named: aString
]
