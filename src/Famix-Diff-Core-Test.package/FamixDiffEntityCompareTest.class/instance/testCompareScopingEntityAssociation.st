tests
testCompareScopingEntityAssociation
	| ass1 ns ass2 ass3 pkg |
	ass1 := FAMIXAccess new.
	ns := FAMIXNamespace new.
	self assert: (ns comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: ns).
	ass2 := FAMIXInvocation new.
	self assert: (ns comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: ns).
	ass3 := FAMIXReference new.
	self assert: (ns comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: ns).
	pkg := FAMIXPackage new.
	self assert: (pkg comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: pkg).
	self assert: (pkg comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: pkg).
	self assert: (pkg comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: pkg)