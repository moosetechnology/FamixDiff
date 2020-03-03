accessing
entityChanges
	<navigation: 'All entity changes'>
	^ self privateState
		cacheAt: #entityChanges
		ifAbsentPut: [ self reject: [ :e | e isForAssociation ] ]