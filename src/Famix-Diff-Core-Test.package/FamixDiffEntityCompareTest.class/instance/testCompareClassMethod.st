tests
testCompareClassMethod
	| meth cl |
	meth := self model entityNamed: 'Smalltalk::A3diff.b3()'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	self assert: (cl comeBeforeEntity: meth ).
	self deny: (meth comeBeforeEntity: cl)