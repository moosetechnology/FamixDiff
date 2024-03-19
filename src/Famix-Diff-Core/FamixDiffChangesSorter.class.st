"
I m sorting the changes that comes from FamixDiff thanks to a graph algorithm. It is avoiding a classification on the entities.
"
Class {
	#name : #FamixDiffChangesSorter,
	#superclass : #FamixDiffAbstractPostOperator,
	#instVars : [
		'graph',
		'changesEntity',
		'changesTargetEntity'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #computation }
FamixDiffChangesSorter >> binaryFindBlock: aKey [
	^ [ :aNode | 
	aNode entity = aKey
		ifTrue: [ 0 ]
		ifFalse: [ aKey hash < aNode entity hash
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ] ]
]

{ #category : #computation }
FamixDiffChangesSorter >> buildEdges [
	graph nodes
		do: [ :node | 
			graph
				edges: node model edgesToRelatedItems
				from: [ :assoc | self findInChanges: assoc key ]
				to: [ :assoc |self findInChanges: assoc value ] ] 
]

{ #category : #computation }
FamixDiffChangesSorter >> calculateChangesOrderOf: aCollectionOfChangesToSort [
	graph := MalLongestPath new.
	graph nodesFromSet: aCollectionOfChangesToSort asSet.
	graph ensureNodesAreSorted.
	self buildEdges.
	graph run.
	^ self sortNodes
]

{ #category : #computation }
FamixDiffChangesSorter >> calculateSortedChanges [
	| entitiesAdded entitiesRemoved |
	entitiesAdded := self calculateChangesOrderOf: self result kindOfEntityAdditionChanges.
	entitiesRemoved := (self calculateChangesOrderOf: self result removalChanges) reverse.
	^ entitiesAdded
		addAll: self result kindOfAssocAdditionChanges asSet;
		addAll: self result versionChanges;
		addAll: self result assocRemovalChanges asSet;
		addAll: entitiesRemoved;
		yourself
]

{ #category : #accessing }
FamixDiffChangesSorter >> changesEntity [
	^ changesEntity ifNil: [ changesEntity := self changes copy ]
]

{ #category : #accessing }
FamixDiffChangesSorter >> changesTargetEntity [
	^ changesTargetEntity ifNil: [ changesTargetEntity := self changes copy ]
]

{ #category : #computation }
FamixDiffChangesSorter >> findInChanges: aKey [
	^ self changesEntity
		findBinary: (self binaryFindBlock: aKey)
		ifNone: [ self changesTargetEntity
				findBinary: (self binaryFindBlock: aKey)
				ifNone: [ self changes
						detect:
							[ :e | e entity mooseID = aKey mooseID or: [ e targetEntity mooseID = aKey mooseID ] ] ] ]
]

{ #category : #accessing }
FamixDiffChangesSorter >> run [
	self sortChanges.
	self result: (FamixDiffResult withAll: self calculateSortedChanges)
]

{ #category : #accessing }
FamixDiffChangesSorter >> sortChanges [
	self changesEntity sort: [ :a :b | a entity hash <= b entity hash ].
	self changesTargetEntity sort: [ :a :b | a targetEntity hash <= b targetEntity hash ]
]

{ #category : #computation }
FamixDiffChangesSorter >> sortNodes [
	| sortedNodes |
	sortedNodes := graph nodes sorted: [ :node1 :node2 | node1 pathWeight <= node2 pathWeight ].
	^ sortedNodes collect: #model
]
