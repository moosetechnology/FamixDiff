"
A FamixDiffResultTest is a test class for testing the behavior of FamixDiffResult
"
Class {
	#name : #FamixDiffResultTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'result'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
FamixDiffResultTest >> setUp [

	| model1 model2 |
	super setUp.
	model1 := self importModelNamed: 'base' fromPackages: #( #'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2' ).
	model2 := self importModelNamed: 'target' fromPackages: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' ).
	result := (FXDiff runOnBaseModel: model1 targetModel: model2) result
]

{ #category : #tests }
FamixDiffResultTest >> testWithoutStubs [

	| withoutStubs |
	self assert: (result anySatisfy: [ :change | change entity isStub ]).

	withoutStubs := result withoutStubs.

	self deny: result identicalTo: withoutStubs. "We want a new collection, not to update the original one."
	self assert: (withoutStubs noneSatisfy: [ :change | change entity isStub ])
]
