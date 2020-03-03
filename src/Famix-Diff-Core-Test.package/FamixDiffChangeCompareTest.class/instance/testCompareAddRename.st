tests
testCompareAddRename
	| att cl add1 rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRenameChange new entity: att.
	add1 := FamixAddChange new entity: cl.
	self assert: (add1 comeBefore: rn ).
	self deny: (rn comeBefore: add1)