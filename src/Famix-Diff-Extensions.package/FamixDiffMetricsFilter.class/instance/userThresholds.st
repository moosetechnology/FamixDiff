pre-format
userThresholds
	^ self selection keys collect: [ :aMetricName |
		|aSelector|
		aSelector := (self selectorForMetricName: aMetricName).
		FamixDiffMetricThreshold 
			selector: aSelector
			min: (self selection at: aMetricName) first
			max: (self selection at: aMetricName) second
		 ]