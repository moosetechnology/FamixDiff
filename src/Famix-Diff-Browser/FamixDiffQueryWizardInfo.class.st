"
The class describes information needed to create wizard pane.

Instance Variables
	typesSelected:		<Object>

typesSelected
	- xxxxx

"
Class {
	#name : #FamixDiffQueryWizardInfo,
	#superclass : #Object,
	#instVars : [
		'typesSelected'
	],
	#category : 'Famix-Diff-Browser'
}

{ #category : #accessing }
FamixDiffQueryWizardInfo >> add: aSymbol [
	(typesSelected includes: aSymbol) ifFalse: [typesSelected add: aSymbol]
]

{ #category : #accessing }
FamixDiffQueryWizardInfo >> remove: aSymbol [
	(typesSelected includes: aSymbol) ifTrue: [typesSelected remove: aSymbol]
]

{ #category : #accessing }
FamixDiffQueryWizardInfo >> typesSelected [
	^ typesSelected
]

{ #category : #accessing }
FamixDiffQueryWizardInfo >> typesSelected: aCollection [
	typesSelected := OrderedCollection new.
	aCollection do: [:each | typesSelected add: each asSymbol ]
]
