"
A generic superclass to describe all kinds of filters on diff browser results.

Instance Variables
	changes:		<Object>
	selection:		<Object>

changes
	- xxxxx

selection
	- xxxxx

"
Class {
	#name : #FamixDiffFilter,
	#superclass : #Object,
	#instVars : [
		'changes',
		'selection'
	],
	#category : 'Famix-Diff-Extensions'
}

{ #category : #accessing }
FamixDiffFilter >> changes [
	^ changes
]

{ #category : #accessing }
FamixDiffFilter >> changes: anObject [
	changes := anObject
]

{ #category : #result }
FamixDiffFilter >> computeResult [
	self subclassResponsibility
]

{ #category : #accessing }
FamixDiffFilter >> selection [
	^ selection ifNil: [ #() ]
]

{ #category : #accessing }
FamixDiffFilter >> selection: anObject [
	selection := anObject
]
