tests
testCompareAddVersion2
	| cl1 cl add1 vs |
	cl1 := FAMIXClass new
		name: 'toto';
		container: FAMIXNamespace new.
	cl := FAMIXClass new
		name: 'titi';
		container: FAMIXNamespace new.
	add1 := FamixAddChange new entity: cl1.
	vs := FamixVersionChange new entity: cl.
	self assert: (vs comeBefore: add1).
	self deny: (add1 comeBefore: vs)