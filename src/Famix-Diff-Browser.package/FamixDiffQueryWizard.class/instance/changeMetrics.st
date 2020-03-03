metrics
changeMetrics
	^ self indicatorsFromChanges values flatten collectAsSet: #label. 
	