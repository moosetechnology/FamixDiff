Class {
	#name : #FamixDiffSortTest,
	#superclass : #FamixDiffTest,
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffSortTest >> setUp [
	snapshot := FXDiff new
		diffTransformers: {FamixDiffChangesSorter};
		yourself
]

{ #category : #tests }
FamixDiffSortTest >> testDiffSortClassesShouldBeRemovedBeforeNamespaces [
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
	delClass := result
		detect: [ :c | c isRemoval and: [ c entity name = 'B4diff' ] ].
	self assert: (result indexOf: delClass) < (result indexOf: delNamespace)
]

{ #category : #'tests - category sorting' }
FamixDiffSortTest >> testDiffSortEntitiesAdditionAndChangeShouldBeDoneBeforeLinksAddition [
	| indexOfLastEntityToAddOrChange indexOfFirstLinkToAdd |
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	indexOfLastEntityToAddOrChange := result findLast: [ :c | (c isRemoval not and: [ c isVersion not ])  and: [ c isForAssociation not ] ].
	indexOfFirstLinkToAdd := result findFirst: [ :c | c isAddition and: [ c isForAssociation ] ].
	self assert: indexOfLastEntityToAddOrChange < indexOfFirstLinkToAdd
]

{ #category : #'tests - category sorting' }
FamixDiffSortTest >> testDiffSortLinksAdditionShouldBeDoneBeforeLinksDeletion [
	| indexOfFirstLinkToDelete indexOfLastLinkToAdd |
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	indexOfLastLinkToAdd := result findLast: [ :c | c isAddition and: [ c isForAssociation ] ].
	indexOfFirstLinkToDelete := result findFirst: [ :c | c isRemoval and: [ c isForAssociation ] ].
	self assert: indexOfLastLinkToAdd < indexOfFirstLinkToDelete
]

{ #category : #'tests - category sorting' }
FamixDiffSortTest >> testDiffSortLinksDeletionShouldBeDoneBeforeEntitiesDeletion [
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
]

{ #category : #tests }
FamixDiffSortTest >> testOrderedDiffClassesShouldBeRemovedBeforeNamespaces [
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
]

{ #category : #'tests - category sorting' }
FamixDiffSortTest >> testOrderedDiffEntitiesAdditionAndChangeShouldBeDoneBeforeLinksAddition [
	| sort indexOfLastEntityToAddOrChange indexOfFirstLinkToAdd |
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	indexOfLastEntityToAddOrChange := result findLast: [ :c | (c isRemoval not and: [ c isVersion not ]) and: [ c isForAssociation not ] ].
	indexOfFirstLinkToAdd := result findFirst: [ :c | c isAddition and: [ c isForAssociation ] ].
	self assert: indexOfLastEntityToAddOrChange < indexOfFirstLinkToAdd
]

{ #category : #'tests - category sorting' }
FamixDiffSortTest >> testOrderedDiffLinksAdditionShouldBeDoneBeforeLinksDeletion [
	| sort indexOfFirstLinkToDelete indexOfLastLinkToAdd |
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
	indexOfLastLinkToAdd := result
		findLast: [ :c | c isAddition and: [ c isForAssociation ] ].
	indexOfFirstLinkToDelete := result
		findFirst: [ :c | c isRemoval and: [ c isForAssociation ] ].
	self assert: indexOfLastLinkToAdd < indexOfFirstLinkToDelete
]

{ #category : #'tests - category sorting' }
FamixDiffSortTest >> testOrderedDiffLinksDeletionShouldBeDoneBeforeEntitiesDeletion [
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
]
