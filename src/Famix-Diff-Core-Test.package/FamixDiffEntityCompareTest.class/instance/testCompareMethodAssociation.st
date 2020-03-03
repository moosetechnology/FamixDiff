tests
testCompareMethodAssociation
	| ass1 meth ass2 ass3 |
	ass1 := FAMIXAccess new.
	meth := FAMIXMethod new parentType: FAMIXClass new.
	self assert: (meth comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: meth).
	ass2 := FAMIXInvocation new.
	self assert: (meth comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: meth).
	ass3 := FAMIXReference new.
	self assert: (meth comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: meth)