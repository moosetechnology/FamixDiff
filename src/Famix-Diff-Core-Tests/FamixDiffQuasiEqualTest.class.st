Class {
	#name : #FamixDiffQuasiEqualTest,
	#superclass : #TestCase,
	#instVars : [
		'typ1',
		'typ2',
		'resolver'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
FamixDiffQuasiEqualTest >> attributeNamed: aString in: aFmxType [

	^ (FamixStAttribute named: aString)
		  parentType: aFmxType;
		  yourself
]

{ #category : #running }
FamixDiffQuasiEqualTest >> classNamed: aString [

	^ FamixStClass named: aString
]

{ #category : #running }
FamixDiffQuasiEqualTest >> methodNamed: aString in: aFmxType [

	^ (FamixStMethod named: aString)
		  parentType: aFmxType;
		  yourself
]

{ #category : #running }
FamixDiffQuasiEqualTest >> setUp [

	super setUp.
	typ1 := self classNamed: 'AClass'.
	self attributeNamed: 'att-A' in: typ1.
	self methodNamed: 'meth-A' in: typ1.

	typ2 := self classNamed: 'AClass'.
	self attributeNamed: 'att-A' in: typ2.
	self methodNamed: 'meth-A' in: typ2.

	resolver := FamixDiffResolver new.
	resolver orchestrator: FXDiff new
]

{ #category : #tests }
FamixDiffQuasiEqualTest >> testType33Percent [

	self attributeNamed: 'att-B' in: typ1.
	self attributeNamed: 'att-C' in: typ2.

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

	self attributeNamed: 'att-B' in: typ1.
	self methodNamed: 'meth-B' in: typ1.

	self attributeNamed: 'att-C' in: typ2.
	self methodNamed: 'meth-C' in: typ2.

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
	typ3 := self classNamed: 'AClass'.

	self attributeNamed: 'att-B' in: typ1.

	self attributeNamed: 'att-C' in: typ3.
	self attributeNamed: 'att-D' in: typ3.
	self methodNamed: 'meth-C' in: typ3.

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

	self attributeNamed: 'att-B' in: typ1.
	self methodNamed: 'meth-B' in: typ1.

	self attributeNamed: 'att-B' in: typ2.
	self methodNamed: 'meth-B' in: typ2.

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

	typ1 := self classNamed: 'AClass'.
	typ2 := self classNamed: 'AClass'.
	self deny: (typ1 hasEqualContentAndDependencies: typ2 resolver: resolver).
	self deny: (typ2 hasEqualContentAndDependencies: typ1 resolver: resolver)
]
