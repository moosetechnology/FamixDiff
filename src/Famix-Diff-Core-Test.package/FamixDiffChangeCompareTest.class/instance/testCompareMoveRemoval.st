tests
testCompareMoveRemoval
	| att cl mv rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: rm ).
	self deny: (rm comeBefore: mv)