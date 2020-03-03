tests
testCompareMethodAttribute
	| att meth |
	att := self model entityNamed: 'Smalltalk::B3diff.att1'.
	meth := self model entityNamed: 'Smalltalk::A3diff.b3()'.
	
	"There is no container relation between att and meth, so it is the mooseName that is taken into account"
	self assert: (meth comeBeforeEntity: att ).
	self deny: (att comeBeforeEntity: meth).