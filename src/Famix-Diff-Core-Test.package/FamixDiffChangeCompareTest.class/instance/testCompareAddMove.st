tests
testCompareAddMove
	| att cl add1 mv |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	add1 := FamixAddChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: add1).
	self deny: (add1 comeBefore: mv)