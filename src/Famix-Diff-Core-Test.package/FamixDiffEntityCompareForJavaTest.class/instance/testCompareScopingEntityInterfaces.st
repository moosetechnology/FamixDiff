tests
testCompareScopingEntityInterfaces
	| interface |
	interface := model entityNamed: #java::io::OutputStream.
	self assert: ((model entityNamed: #java::lang::Object) comeBeforeEntity: interface).
	self assert: ((model entityNamed: #java::io::Closeable) comeBeforeEntity: interface).
	self assert: ((model entityNamed: #java::io::Flushable) comeBeforeEntity: interface).
	self deny: (interface comeBeforeEntity: (model entityNamed: #java::lang::Object)).
	self deny: (interface comeBeforeEntity: (model entityNamed: #java::io::Closeable)).
	self deny: (interface comeBeforeEntity: (model entityNamed: #java::io::Flushable))