tests
testCompareAddMove3
	| att ass add1 mv |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	ass := (self model entityNamed: 'Smalltalk::A3diff') incomingReferences first.
	
	add1 := FamixAddChange new entity: ass.
	mv := FamixMoveChange new entity: att.
	self assert: (mv comeBefore: add1 ).
	self deny: (add1 comeBefore: mv).