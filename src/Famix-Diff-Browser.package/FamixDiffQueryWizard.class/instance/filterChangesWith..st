filtering
filterChangesWith: aDictionaryOfSelections
	| filterParams|
	filterParams := FamixDiffFilterParameters new
		changes: (((aDictionaryOfSelections at: #selectedChanges) select: #value) collect: #key);
		types: (((aDictionaryOfSelections at:#selectedTypes) select: #value) collect: #key);
		metrics:	(self getMetricsForFilteringFrom: aDictionaryOfSelections);
		yourself.
	self browser displayedChanges: (self browser changesComputation filterChangesWith: filterParams).
	
	
	