tests
testCompareScopingEntityClass2
	| ns cl pkg |
	pkg := (self model entityNamed: 'Moose-TestResources-ModelDiff-P3') name: 'Toto'.
	cl := self model entityNamed: 'Smalltalk::A4diff'.
	self assert: (pkg comeBeforeEntity: cl).
	self deny: (cl comeBeforeEntity: pkg).
	
	ns := self model entityNamed: 'Smalltalk'.
	self assert: (ns comeBeforeEntity: cl).
	self deny: (cl comeBeforeEntity: ns)