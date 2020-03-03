sort-params
sortMetric
	^ self selection isEmpty
		ifTrue: [ 1 ]
		ifFalse: [ self selection first ]