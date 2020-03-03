tests
testTypeDifferent
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
