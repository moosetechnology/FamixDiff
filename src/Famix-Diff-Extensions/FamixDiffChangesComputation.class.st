"
The class holds a collection of changes computed from the two input model and provides some helpful methods to get info for these changes.

Instance Variables
	changes:		<Object>

changes
	- xxxxx

"
Class {
	#name : #FamixDiffChangesComputation,
	#superclass : #Object,
	#instVars : [
		'famixDiff',
		'changes',
		'displayedChanges',
		'typesFilter',
		'changesFilter',
		'metricsFilter',
		'metricsSorter'
	],
	#category : #'Famix-Diff-Extensions'
}

{ #category : #'change-metrics' }
FamixDiffChangesComputation >> changeMetrics [
	^ self changeMetricsFor: self typesChanged
]

{ #category : #'change-metrics' }
FamixDiffChangesComputation >> changeMetricsFor: aTypeCollection [
	^ self changeMetricsFor: aTypeCollection withChanges: self changes.	
]

{ #category : #'change-metrics' }
FamixDiffChangesComputation >> changeMetricsFor: aTypeCollection withChanges: aChangesCollection [
	| metricsDict |
	metricsDict := Dictionary new.
	(aChangesCollection
		select: [ :aChange | aTypeCollection includes: aChange entity class displayName ])
		do: [ :aChange | 
			metricsDict
				at: aChange entity class displayName asSymbol
				ifAbsentPut: [ aChange entityChangeIndicators ] ].
	^ metricsDict
]

{ #category : #'change-metrics' }
FamixDiffChangesComputation >> changeMetricsForDisplayedChanges [
	^ self changeMetricsFor: self typesChanged withChanges: self displayedChanges
]

{ #category : #'changes-search' }
FamixDiffChangesComputation >> changeTypes [
	^ self changes collectAsSet: [:aChange | aChange class displayName].
]

{ #category : #accessing }
FamixDiffChangesComputation >> changes [
	^ changes ifNil: [ changes := self famixDiffResult allEntitiesImpactingChanges asSet ]
]

{ #category : #private }
FamixDiffChangesComputation >> changesFilter [
	^ changesFilter ifNil: [ changesFilter := FamixDiffChangesFilter new. ]
]

{ #category : #accessing }
FamixDiffChangesComputation >> displayedChanges [
	^ displayedChanges ifNil: [self changes]
]

{ #category : #accessing }
FamixDiffChangesComputation >> displayedChanges: anObject [
	displayedChanges := anObject
]

{ #category : #private }
FamixDiffChangesComputation >> famixDiff [
	^ famixDiff
]

{ #category : #accessing }
FamixDiffChangesComputation >> famixDiffResult [
	^ self famixDiff result
]

{ #category : #'filtering-and-sort' }
FamixDiffChangesComputation >> filterChangesWith: filterParameters [
	| changesAfterFilter |
	changesAfterFilter := self changesFilter
		changes: self changes;
		selection: filterParameters changes;
		computeResult.
	changesAfterFilter := self typesFilter
		changes: changesAfterFilter;
		selection: filterParameters types;
		computeResult.
	^ self metricsFilter
		changes: changesAfterFilter;
		selection: filterParameters metrics;
		computeResult
]

{ #category : #initialization }
FamixDiffChangesComputation >> initializeDiffwith: base and: target [
	self assert: (base isKindOf: MooseModel).
	self assert: (target isKindOf: MooseModel).
	base == target
		ifTrue: [ displayedChanges := #().
			^ self ].
	displayedChanges := nil.
	Cursor wait showWhile: [ famixDiff := FXDiff runOnBaseModel: base targetModel: target ]
]

{ #category : #private }
FamixDiffChangesComputation >> metricsFilter [
	^ metricsFilter ifNil: [ metricsFilter := FamixDiffMetricsFilter new changes: self changes; yourself ]
]

{ #category : #private }
FamixDiffChangesComputation >> metricsSorter [
	^ metricsSorter ifNil: [ metricsSorter := FamixDiffMetricsSorter new changes: self changes; yourself ]
]

{ #category : #'filtering-and-sort' }
FamixDiffChangesComputation >> sortChangesWith: aCollection [
	^ self metricsSorter selection: aCollection; changes: self displayedChanges; computeResult 
]

{ #category : #'changes-search' }
FamixDiffChangesComputation >> typesChanged [
	^ self changes collectAsSet: [ :each | each entity class displayName ].
]

{ #category : #private }
FamixDiffChangesComputation >> typesFilter [
	^ typesFilter ifNil: [ typesFilter := FamixDiffTypeFilter new changes: self changes; yourself. ]
]
