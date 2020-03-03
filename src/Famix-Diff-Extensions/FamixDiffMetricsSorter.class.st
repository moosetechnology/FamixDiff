"
Implements the sorting of change list in the browser.
"
Class {
	#name : #FamixDiffMetricsSorter,
	#superclass : #FamixDiffMetricsFilter,
	#instVars : [
		'sortSelector'
	],
	#category : 'Famix-Diff-Extensions'
}

{ #category : #sorting }
FamixDiffMetricsSorter >> compareChange: aChange with: anotherChange [
	| indicatorOne indicatorTwo |
	indicatorOne := aChange changeMetrics detect: [:indic | indic selector = self sortSelector] ifNone: [^false].
	indicatorTwo := anotherChange changeMetrics detect: [:indic | indic selector = self sortSelector] ifNone: [^false].
	^ indicatorOne computedValue abs perform: self sortComparator with: indicatorTwo computedValue abs
]

{ #category : #result }
FamixDiffMetricsSorter >> computeResult [
	^  (self changes select: [ :c | c entity respondsTo: self sortSelector ]) asSet sorted: [:aChange :anotherChange | self compareChange: aChange with: anotherChange].
]

{ #category : #'as yet unclassified' }
FamixDiffMetricsSorter >> selection: anObject [
	selection := anObject.
	sortSelector := nil.
]

{ #category : #'sort-params' }
FamixDiffMetricsSorter >> sortComparator [
	^ self sortDirection = 'Ascending'
		ifTrue: [ #< ]
		ifFalse: [ #> ]
]

{ #category : #'sort-params' }
FamixDiffMetricsSorter >> sortDirection [
	^ self selection isEmpty
		ifTrue: [ 'Descending' ]
		ifFalse: [ self selection second ]
]

{ #category : #'sort-params' }
FamixDiffMetricsSorter >> sortMetric [
	^ self selection isEmpty
		ifTrue: [ 1 ]
		ifFalse: [ self selection first ]
]

{ #category : #'as yet unclassified' }
FamixDiffMetricsSorter >> sortSelector [
	^ sortSelector ifNil: [sortSelector := self selectorForMetricName: self selection first]
]
