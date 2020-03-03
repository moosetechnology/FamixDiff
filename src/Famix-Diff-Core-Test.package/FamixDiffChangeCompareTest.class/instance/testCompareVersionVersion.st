tests
testCompareVersionVersion
	| att cl vs1 vs2 |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	vs1 := FamixVersionChange new entity: att.
	vs2 := FamixVersionChange new entity: cl.
	self assert: (vs2 comeBefore: vs1 ).
	self deny: (vs1 comeBefore: vs2)