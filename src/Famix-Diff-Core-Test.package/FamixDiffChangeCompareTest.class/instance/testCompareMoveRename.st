tests
testCompareMoveRename
	| att cl mv rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRemovalChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: rn ).
	self deny: (rn comeBefore: mv)