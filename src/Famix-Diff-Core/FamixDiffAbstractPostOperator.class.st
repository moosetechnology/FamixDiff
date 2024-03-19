"
I operate of the diff of 2 models. Please use me through FamixDiffOrchestrator.

TODO
"
Class {
	#name : #FamixDiffAbstractPostOperator,
	#superclass : #FamixDiffAbstract,
	#category : #'Famix-Diff-Core'
}

{ #category : #accessing }
FamixDiffAbstractPostOperator >> run [
	self subclassResponsibility
]
