tests
testCompareAddAdd
	| att cl add1 add2 |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	add1 := FamixAddChange new entity: att.
	add2 := FamixAddChange new entity: cl.
	self assert: (add2 comeBefore: add1).
	self deny: (add1 comeBefore: add2)