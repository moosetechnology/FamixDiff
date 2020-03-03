"
FamixDiffIndicator is ab object to group display information for the metrics associated with the changes.

Instance Variables
	computedValue:		<Object>
	label:		<Object>
	selector:		<Object>

computedValue
	- xxxxx

label
	- xxxxx

selector
	- xxxxx

"
Class {
	#name : #FamixDiffIndicator,
	#superclass : #Object,
	#instVars : [
		'selector',
		'label',
		'computedValue'
	],
	#category : 'Famix-Diff-Extensions'
}

{ #category : #'as yet unclassified' }
FamixDiffIndicator class >> selector: aSelector label: aLabel [
	^self new selector: aSelector; label: aLabel; yourself
]

{ #category : #'as yet unclassified' }
FamixDiffIndicator class >> selector: aSelector label: aLabel entity: anEntity [
	^self new selector: aSelector; label: aLabel; entity:anEntity 
]

{ #category : #accessing }
FamixDiffIndicator >> computedValue [
	^ computedValue
]

{ #category : #accessing }
FamixDiffIndicator >> computedValue: anObject [
	computedValue := anObject
]

{ #category : #accessing }
FamixDiffIndicator >> label [
	^ label
]

{ #category : #accessing }
FamixDiffIndicator >> label: anObject [
	label := anObject
]

{ #category : #accessing }
FamixDiffIndicator >> selector [
	^ selector
]

{ #category : #accessing }
FamixDiffIndicator >> selector: anObject [
	selector := anObject
]
