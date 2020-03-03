Class {
	#name : #FamixDiffEntityCompareForJavaTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffEntityCompareForJavaTest >> setUp [ 
	model := VerveineJTestResource current model
]

{ #category : #tests }
FamixDiffEntityCompareForJavaTest >> testCompareScopingEntityInterfaces [
	| interface |
	interface := model entityNamed: #java::io::OutputStream.
	self assert: ((model entityNamed: #java::lang::Object) comeBeforeEntity: interface).
	self assert: ((model entityNamed: #java::io::Closeable) comeBeforeEntity: interface).
	self assert: ((model entityNamed: #java::io::Flushable) comeBeforeEntity: interface).
	self deny: (interface comeBeforeEntity: (model entityNamed: #java::lang::Object)).
	self deny: (interface comeBeforeEntity: (model entityNamed: #java::io::Closeable)).
	self deny: (interface comeBeforeEntity: (model entityNamed: #java::io::Flushable))
]

{ #category : #tests }
FamixDiffEntityCompareForJavaTest >> testTypesIncludedInsideMethodsComeBefore [
	|  methodsWithTypes method |
	methodsWithTypes := model allMethods select: [ :m | m types isNotEmpty ].
	method := methodsWithTypes entityNamed: #'<Default Package>::Dictionary.createFamixEntity(Class<T>,String)'.
	self deny: (method types first comeBeforeEntity: method).
	self assert: (method comeBeforeEntity: method types first).
	
]
