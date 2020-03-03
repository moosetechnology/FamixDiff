tests
testCompareScopingEntityAttribute2
	| ns att pkg  |
	pkg := (self model entityNamed: 'Moose-TestResources-ModelDiff-P3') name: 'Toto'.
	att := self model entityNamed: 'Smalltalk::A4diff.att1'.
	self assert: (pkg comeBeforeEntity: att).
	self deny: (att comeBeforeEntity: pkg).
	
	ns := self model entityNamed: 'Smalltalk'.
	self assert: (ns comeBeforeEntity: att).
	self deny: (att comeBeforeEntity: ns).