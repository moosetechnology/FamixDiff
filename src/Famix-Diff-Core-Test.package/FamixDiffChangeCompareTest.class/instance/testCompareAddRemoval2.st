tests
testCompareAddRemoval2
	| att cl add1 rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: cl.
	add1 := FamixAddChange new entity: att.
	self deny: (add1 comeBefore: rm ).
	self assert: (rm comeBefore: add1)