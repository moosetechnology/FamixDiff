filtering-and-sort
filterChangesWith: filterParameters
	| changesAfterFilter |
	changesAfterFilter := self changesFilter
		changes: self changes;
		selection: filterParameters changes;
		computeResult.
	changesAfterFilter := self typesFilter
		changes: changesAfterFilter;
		selection: filterParameters types;
		computeResult.
	^ self metricsFilter
		changes: changesAfterFilter;
		selection: filterParameters metrics;
		computeResult