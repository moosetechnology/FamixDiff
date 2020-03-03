running
testFilterChanges
	| changes filterParams|
	filterParams := FamixDiffFilterParameters new changes: #('Add'); types: #('Package'); metrics: {'Name Length' -> #(30 40)} asDictionary; yourself.
	changes := changesComputation filterChangesWith: filterParams.
	self assert: changes size equals: 1.
	self assert: changesComputation typesFilter selection size equals: 1.
	self assert: changesComputation typesFilter selection first equals: FAMIXPackage.
	self assert: changesComputation changesFilter selection size equals: 1.
	self assert: changesComputation changesFilter selection first equals: FamixAddChange.
	self assert: changesComputation metricsFilter selection size equals: 1.
	self assert: changesComputation metricsFilter selection keys first equals: 'Name Length'.
	self assert: changesComputation metricsFilter selection values first size equals: 2.
	