"
A metrics filter class takes the information from the wizard and filters the metrics that are between the provided thresholds.

"
Class {
	#name : #FamixDiffMetricsFilter,
	#superclass : #FamixDiffFilter,
	#category : 'Famix-Diff-Extensions'
}

{ #category : #result }
FamixDiffMetricsFilter >> computeResult [
	^ self changes select: [:aChange | 
		self shouldIcludeInResults: aChange].
	
]

{ #category : #'pre-format' }
FamixDiffMetricsFilter >> selectorForMetricName: aString [
	| indFound |
	indFound := self changes
		collect: [ :aChange | 
			aChange entityChangeIndicators
				do: [ :ind | 
					(ind label compare: aString) = 2
						ifTrue: [ ^ ind selector ] ] ].
]

{ #category : #result }
FamixDiffMetricsFilter >> shouldIcludeInResults: aChange [
	aChange changeMetrics
		do: [ :indicator | 
			self userThresholds
				do: [ :aTh | 
					aTh selector = indicator selector
						ifTrue: [ 
							(aTh numberRespects: indicator computedValue)
								ifFalse: [ ^ false ] ] ] ].
	^ true
]

{ #category : #'pre-format' }
FamixDiffMetricsFilter >> userThresholds [
	^ self selection keys collect: [ :aMetricName |
		|aSelector|
		aSelector := (self selectorForMetricName: aMetricName).
		FamixDiffMetricThreshold 
			selector: aSelector
			min: (self selection at: aMetricName) first
			max: (self selection at: aMetricName) second
		 ]
]
