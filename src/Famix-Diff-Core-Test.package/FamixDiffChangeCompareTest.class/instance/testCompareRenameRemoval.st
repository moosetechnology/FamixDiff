tests
testCompareRenameRemoval
	| att cl rn rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: att.
	rn := FamixRenameChange new entity: cl.
	self assert: (rn comeBefore: rm ).
	self deny: (rm comeBefore: rn)