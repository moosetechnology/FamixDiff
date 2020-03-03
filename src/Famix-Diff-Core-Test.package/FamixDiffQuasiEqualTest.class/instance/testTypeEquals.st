tests
testTypeEquals
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
