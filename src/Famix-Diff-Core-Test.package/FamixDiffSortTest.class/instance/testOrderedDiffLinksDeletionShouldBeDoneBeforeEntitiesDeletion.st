tests - category sorting
testOrderedDiffLinksDeletionShouldBeDoneBeforeEntitiesDeletion
	| sort indexOfLastLinkToDelete indexOfFirstEntityToDelete |
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
	indexOfLastLinkToDelete := result
		findLast: [ :c | c isRemoval and: [ c isForAssociation ] ].
	indexOfFirstEntityToDelete := result
		findFirst: [ :c | c isRemoval and: [ c isForAssociation not ] ].
	self assert: indexOfLastLinkToDelete < indexOfFirstEntityToDelete