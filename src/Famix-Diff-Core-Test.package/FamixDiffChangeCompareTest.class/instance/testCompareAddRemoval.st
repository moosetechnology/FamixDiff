tests
testCompareAddRemoval
	| att cl add1 rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: att.
	add1 := FamixAddChange new entity: cl.
	self assert: (add1 comeBefore: rm ).
	self deny: (rm comeBefore: add1)