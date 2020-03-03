computation
findInChanges: aKey
	^ self changesEntity
		findBinary: (self binaryFindBlock: aKey)
		ifNone: [ self changesTargetEntity
				findBinary: (self binaryFindBlock: aKey)
				ifNone: [ self changes
						detect:
							[ :e | e entity mooseID = aKey mooseID or: [ e targetEntity mooseID = aKey mooseID ] ] ] ]