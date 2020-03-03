tests
testCompareAddMove2
	| att att2 add1 mv |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	att2 := self model entityNamed: 'Smalltalk::A3diff.att2'.
	
	add1 := FamixAddChange new entity: att2.
	mv := FamixMoveChange new entity: att.
	self assert: (add1 comeBefore: mv).
	self deny: (mv comeBefore: add1).