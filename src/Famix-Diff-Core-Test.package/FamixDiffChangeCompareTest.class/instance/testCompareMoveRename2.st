tests
testCompareMoveRename2
	| att cl mv rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRemovalChange new entity: cl.
	mv := FamixMoveChange new entity: att.
	self deny: (mv comeBefore: rn ).
	self assert: (rn comeBefore: mv)