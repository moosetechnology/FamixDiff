computation
calculateChangesOrderOf: aCollectionOfChangesToSort
	graph := MalLongestPath new.
	graph nodesFromSet: aCollectionOfChangesToSort asSet.
	graph ensureNodesAreSorted.
	self buildEdges.
	graph run.
	^ self sortNodes