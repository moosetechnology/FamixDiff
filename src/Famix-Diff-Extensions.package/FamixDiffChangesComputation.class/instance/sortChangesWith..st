filtering-and-sort
sortChangesWith: aCollection
	^ self metricsSorter selection: aCollection; changes: self displayedChanges; computeResult 