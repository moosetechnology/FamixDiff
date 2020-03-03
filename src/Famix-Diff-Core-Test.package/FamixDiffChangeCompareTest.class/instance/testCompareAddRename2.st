tests
testCompareAddRename2
	| att cl add1 rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRenameChange new entity: cl.
	add1 := FamixAddChange new entity: att.
	self deny: (add1 comeBefore: rn ).
	self assert: (rn comeBefore: add1)