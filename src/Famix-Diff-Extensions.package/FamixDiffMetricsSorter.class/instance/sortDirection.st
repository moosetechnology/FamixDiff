sort-params
sortDirection
	^ self selection isEmpty
		ifTrue: [ 'Descending' ]
		ifFalse: [ self selection second ]