tests
testCompareScopingEntityMethod
	| ns meth pkg |
	pkg := FAMIXPackage new.
	meth := FAMIXMethod new parentType: FAMIXClass new.
	self assert: (pkg comeBeforeEntity: meth).
	self deny: (meth comeBeforeEntity: pkg).
	ns := FAMIXNamespace new.
	self assert: (ns comeBeforeEntity: meth).
	self deny: (meth comeBeforeEntity: ns)