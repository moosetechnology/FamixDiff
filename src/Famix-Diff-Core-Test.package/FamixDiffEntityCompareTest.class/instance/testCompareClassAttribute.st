tests
testCompareClassAttribute
	| att cl |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	self assert: (cl comeBeforeEntity: att ).
	self deny: (att comeBeforeEntity: cl)