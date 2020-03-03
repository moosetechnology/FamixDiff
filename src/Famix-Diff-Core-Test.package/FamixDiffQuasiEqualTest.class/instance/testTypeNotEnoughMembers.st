tests
testTypeNotEnoughMembers
	self deny: (typ1 quasiEqualBody: typ2 tolerance: 1).
	self deny: (typ2 quasiEqualBody: typ1 tolerance: 1)