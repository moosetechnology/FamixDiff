"
I am a diff utility for FAMIX models.

I hold two models:
- The base model stored in #base instance variable.
- The target model stored in #target instance variable.

Once I computed the difference (delta) between #base and #target models by executing #diff method,
- I store the entity changes in #changes instance variable.
- I store the associations changes in #assocChanges variable.

My #tolerance instance variable is used to give some flexibility for the match between two entities.
Indeed, this variable is a real between 0 and 1 that represents the percentage of tolerance for a match.
- tolerance = 0 (0%)      implies that both entities must be strictly equals.
- tolerance = 1 (100%) implies that entities can be completly different.
"
Class {
	#name : #FamixDiff,
	#superclass : #FamixDiffAbstractComputer,
	#instVars : [
		'changes',
		'assocChanges'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #'run-associations' }
FamixDiff >> addAssociations: assocs [
	assocs do: [ :a | self assocChanges add: (FamixAddChange new entity: a ; yourself) ]
]

{ #category : #accessing }
FamixDiff >> assocChanges [
	^ assocChanges
]

{ #category : #accessing }
FamixDiff >> assocChanges: aCollection [
	^ assocChanges := aCollection
]

{ #category : #accessing }
FamixDiff >> changesDico [
	^ changes
]

{ #category : #accessing }
FamixDiff >> changesDico: aCollection [
	changes := aCollection
]

{ #category : #'run-associations' }
FamixDiff >> checkAssocsMatches: baseAssocs with: targetAssocs tolerance: anObject [
	baseAssocs
		do: [ :baseAss | 
			targetAssocs
				detect: [ :targetAss | targetAss matches: baseAss givenChanges: self changesDico ]
				ifOne: [ :found | targetAssocs remove: found ]
				ifNone: [ 
					self assocChanges
						add:
							(FamixRemovalChange new
								entity: baseAss;
								yourself) ]	"not creating FAMIXMatchChange for associations" ].
	self addAssociations: targetAssocs
]

{ #category : #'run-associations' }
FamixDiff >> delAssociations: assocs [
	assocs
		do: [ :a | 
			self assocChanges
				add:
					(FamixRemovalChange new
						entity: a;
						yourself) ]
]

{ #category : #run }
FamixDiff >> diff [
	"Compute the diff between the #base MooseModel and the #target MooseModel."

	self diffEntities.
	self diffAssociations.
	self result addAll: self changesDico values asSet.
	self result addAll: self assocChanges asSet
]

{ #category : #'run-associations' }
FamixDiff >> diffAssociations [
	(self changesDico values asSet asOrderedCollection
		"sorted: [ :a :b | a printString <= b printString ]")
		do: [ :chg | chg updateDiffForAssociations: self ]
		"displayingProgress: 'Comparing entity associations'"
]

{ #category : #'run-entities' }
FamixDiff >> diffEntities [
	| baseTodo targetTodo |

	"loops on this block"
	[ baseTodo := (self topEntitiesToMatch: self baseModel)
		asOrderedCollection.
	targetTodo := (self topEntitiesToMatch: self targetModel)
		asOrderedCollection.

	"as soon as one return true, go to next loop iteration"
	(self identityMatchesFrom: baseTodo to: targetTodo)
		or: [ (self renameMatchesFrom: baseTodo to: targetTodo)
				or: [ (self moveMatchesFrom: baseTodo)
						or: [ self moveMatchesTo: targetTodo ] ] ] ] whileTrue.

	"Each entities in base model that couldn't be matched with entity in target model is considered as removed."
	(self entitiesToMatch: self baseModel)
		do: [ :e | 
			self changesDico
				at: e
				put: (self makeChange: FamixRemovalChange with: e) ].

	"Each entities in target model that couldn't be matched with entity in base model is considered as added."
	(self entitiesToMatch: self targetModel)
		do:
			[ :e | self changesDico at: e put: (self makeChange: FamixAddChange with: e) ]
]

{ #category : #'run-entities' }
FamixDiff >> entitiesToMatch: aModel [
	"not stub, not matched entities"
	^ aModel entities select: [:e | self entityToMatch: e ]

]

{ #category : #'run-entities' }
FamixDiff >> entityToMatch: entity [
	"not stub, not matched"
	^ entity isNotNil
		and: [ (entity shouldBeConsideredForDiff) 
		and: [ (self matched: entity) not ] ]
]

{ #category : #'matching-entities' }
FamixDiff >> identityMatchesFrom: baseEntities to: targetEntities [
	"Find the entities that are exactly the same between base version and target version (using #identityMatch:givenChanges: message).
	 If there is a match, a FamixVersionChange is created and stored."

	^ self
		matches: [ :eBase :eTarget | eBase identityMatch: eTarget givenChanges: self changesDico ]
		from: baseEntities
		to: targetEntities
		ifMatch: [ :eBase :eTarget | 
			| match |
			targetEntities remove: eTarget.
			match := self makeChange: FamixVersionChange with: eBase with: eTarget.
			self changesDico
				at: eBase put: match;
				at: eTarget put: match ]
		progressMessage: 'Comparing two versions' translated
]

{ #category : #'as yet unclassified' }
FamixDiff >> initialize [
	super initialize.
	changes := Dictionary new.
	assocChanges := OrderedCollection new
]

{ #category : #'change-creation' }
FamixDiff >> makeChange: changeClass with: entity [
	^ changeClass new
			entity: entity
			yourself.

]

{ #category : #'change-creation' }
FamixDiff >> makeChange: changeClass with: baseEntity with: targetEntity [
	^ changeClass new
			baseEntity: baseEntity ;
			targetEntity: targetEntity ;
			yourself.

]

{ #category : #testing }
FamixDiff >> matched: entity [
	^ self changesDico includesKey: entity
]

{ #category : #'matching-entities' }
FamixDiff >> matches: matchblock from: baseEntities to: targetEntities ifMatch: ifMatchBlock progressMessage: aString [
	"Find matches defined by matchblock (returns true -> match) between baseEntities and targetEntities.
	 matchblock takes 2 parameters: first is baseEntity, second is targetEntity being compared.
	
	 When a match is found, ifMatchBlock is evaluated with the base entity as first parameter and the target entity as second parameter.
	 The progress message is displayed by the UI during the computation.
	
	 This algorithm essentially takes each entity from baseEntities and try to match them with an entity in targetEntity list."
	| matchFound |
	matchFound := false.
	baseEntities
		do: [ :eBase | 
			targetEntities
				detect: [ :eTarget | matchblock value: eBase value: eTarget ]
				ifOne: [ :eTarget |
					ifMatchBlock value: eBase value: eTarget.
					matchFound := true ] ]
		displayingProgress: aString.
	^ matchFound
]

{ #category : #'run-entities' }
FamixDiff >> moveCandidates: aModel [
	"not stub, not matched entities"
	^ self entitiesToMatch: aModel
]

{ #category : #'matching-entities' }
FamixDiff >> moveMatches: entities direction: fromOrToDirection [
	| from to matchesBlock |
	fromOrToDirection = #to
		ifTrue: [ from := self moveCandidates: self baseModel.
			to := entities.
			matchesBlock := [ :eBase :eTarget | eTarget moveMatch: eBase givenChanges: self changesDico tolerance: self tolerance ] ]
		ifFalse: [ from := entities.
			to := self moveCandidates: self targetModel.
			matchesBlock := [ :eBase :eTarget | eBase moveMatch: eTarget givenChanges: self changesDico tolerance: self tolerance ] ].
	^ self
		matches: matchesBlock
		from: from
		to: to
		ifMatch: [ :eBase :eTarget | 
			| match |
			match := self makeChange: FamixMoveChange with: eBase with: eTarget.
			self changesDico at: eBase put: match; at: eTarget put: match ]
		progressMessage: 'Computing modifications' translated
]

{ #category : #'matching-entities' }
FamixDiff >> moveMatchesFrom: baseEntities [
	^ self moveMatches: baseEntities direction: #from
]

{ #category : #'matching-entities' }
FamixDiff >> moveMatchesTo: targetEntities [
	^ self moveMatches: targetEntities direction: #to
]

{ #category : #'matching-entities' }
FamixDiff >> renameMatchesFrom: baseEntities to: targetEntities [
	"Find the entities that have been renamed between base version and target version (using #renameMatch:givenChanges:tolerance: message).
	 If there is a match, a FamixRenameChange is created and stored."

	^ self
		matches: [ :eBase :eTarget | eBase renameMatch: eTarget givenChanges: self changesDico tolerance: self tolerance ]
		from: baseEntities
		to: targetEntities
		ifMatch: [ :eBase :eTarget | 
			| match |
1haltIf:[ baseEntities name endsWith: '-P4'].
			match := self makeChange: FamixRenameChange with: eBase with: eTarget.
			self changesDico
				at: eBase put: match;
				at: eTarget put: match ]
		progressMessage: 'Computing renamed entities' translated
]

{ #category : #'run-entities' }
FamixDiff >> topEntitiesToMatch: aModel [
	"topmost, not stub, not matched entities"
	^ (self entitiesToMatch: aModel)
		select: [:e ||parent|
				parent := e belongsTo.
				(self entityToMatch: parent) not or: [self matched: parent] ]

]
