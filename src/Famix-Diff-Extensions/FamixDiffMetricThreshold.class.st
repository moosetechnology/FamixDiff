"
Thresolds for the metrics of the changes.

Instance Variables
	max:		<Object>
	min:		<Object>
	selector:		<Object>

max
	- xxxxx

min
	- xxxxx

selector
	- xxxxx

"
Class {
	#name : #FamixDiffMetricThreshold,
	#superclass : #Object,
	#instVars : [
		'selector',
		'min',
		'max'
	],
	#category : 'Famix-Diff-Extensions'
}

{ #category : #'as yet unclassified' }
FamixDiffMetricThreshold class >> selector: aSelector min: min max: max [
	^self new selector: aSelector; min: min; max: max; yourself.
]

{ #category : #accessing }
FamixDiffMetricThreshold >> max [
	^ max
]

{ #category : #accessing }
FamixDiffMetricThreshold >> max: anObject [
	max := anObject
]

{ #category : #accessing }
FamixDiffMetricThreshold >> min [
	^ min
]

{ #category : #accessing }
FamixDiffMetricThreshold >> min: anObject [
	min := anObject
]

{ #category : #'as yet unclassified' }
FamixDiffMetricThreshold >> numberRespects: aNumber [
	^ self min <= aNumber and: [ self max>= aNumber ]
]

{ #category : #accessing }
FamixDiffMetricThreshold >> selector [
	^ selector
]

{ #category : #accessing }
FamixDiffMetricThreshold >> selector: anObject [
	selector := anObject
]
