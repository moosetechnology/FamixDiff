tests - category sorting
testDiffSortEntitiesAdditionAndChangeShouldBeDoneBeforeLinksAddition
	| indexOfLastEntityToAddOrChange indexOfFirstLinkToAdd |
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	indexOfLastEntityToAddOrChange := result findLast: [ :c | (c isRemoval not and: [ c isVersion not ])  and: [ c isForAssociation not ] ].
	indexOfFirstLinkToAdd := result findFirst: [ :c | c isAddition and: [ c isForAssociation ] ].
	self assert: indexOfLastEntityToAddOrChange < indexOfFirstLinkToAdd