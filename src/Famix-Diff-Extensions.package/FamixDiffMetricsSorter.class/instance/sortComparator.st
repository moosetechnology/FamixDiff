sort-params
sortComparator
	^ self sortDirection = 'Ascending'
		ifTrue: [ #< ]
		ifFalse: [ #> ]