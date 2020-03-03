running
setUp
	typ1 := self typeNamed: 'AClass'.
	self attNamed: 'att-A' inClass: typ1.
	self methNamed: 'meth-A' inClass: typ1.

	typ2 := self typeNamed: 'AClass'.
	self attNamed: 'att-A' inClass: typ2.
	self methNamed: 'meth-A' inClass: typ2