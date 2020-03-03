tests - category sorting
testDiffSortLinksAdditionShouldBeDoneBeforeLinksDeletion
	| indexOfFirstLinkToDelete indexOfLastLinkToAdd |
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	indexOfLastLinkToAdd := result findLast: [ :c | c isAddition and: [ c isForAssociation ] ].
	indexOfFirstLinkToDelete := result findFirst: [ :c | c isRemoval and: [ c isForAssociation ] ].
	self assert: indexOfLastLinkToAdd < indexOfFirstLinkToDelete