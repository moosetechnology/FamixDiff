tests
testOrderedDiffClassesShouldBeRemovedBeforeNamespaces
	| sort delNamespace delClass |
	snapshot
		baseModel:
			(self
				createModelWith:
					#(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3')).
	snapshot
		targetModel:
			(self
				createModelWith:
					#(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	delNamespace := result entityChanges
		detect: [ :c | 
			c isRemoval
				and: [ c entity name = 'Moose-TestResources-ModelDiff-P4' ] ].
	delClass := result entityChanges
		detect: [ :c | c isRemoval and: [ c entity name = 'B4diff' ] ].
	self assert: (result indexOf: delClass) < (result indexOf: delNamespace)