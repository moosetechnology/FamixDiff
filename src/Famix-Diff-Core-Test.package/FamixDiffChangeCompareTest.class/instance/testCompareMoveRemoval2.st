tests
testCompareMoveRemoval2
	| att cl mv rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: cl.
	mv := FamixMoveChange new entity: att.
	self deny: (mv comeBefore: rm ).
	self assert: (rm comeBefore: mv)