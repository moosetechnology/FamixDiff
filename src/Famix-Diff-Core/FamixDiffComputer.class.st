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
	#name : #FamixDiffComputer,
	#superclass : #FamixDiffAbstract,
	#instVars : [
		'changes',
		'assocChanges'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #'run-associations' }
FamixDiffComputer >> addAssociations: assocs [
	assocs do: [ :a | self assocChanges add: (FamixAddChange new entity: a ; yourself) ]
]

{ #category : #accessing }
FamixDiffComputer >> assocChanges [
	^ assocChanges
]

{ #category : #accessing }
FamixDiffComputer >> assocChanges: aCollection [
	^ assocChanges := aCollection
]

{ #category : #accessing }
FamixDiffComputer >> changesDico [
	^ changes
]

{ #category : #accessing }
FamixDiffComputer >> changesDico: aCollection [
	changes := aCollection
]

{ #category : #'run-associations' }
FamixDiffComputer >> checkAssocsMatches: baseAssocs with: targetAssocs tolerance: anObject [
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
FamixDiffComputer >> delAssociations: assocs [
	assocs
		do: [ :a | 
			self assocChanges
				add:
					(FamixRemovalChange new
						entity: a;
						yourself) ]
]

{ #category : #run }
FamixDiffComputer >> diff [
	"Compute the diff between the #base MooseModel and the #target MooseModel."

	self diffEntities.
	self diffAssociations.
	self result addAll: self changesDico values asSet.
	self result addAll: self assocChanges asSet
]

{ #category : #'run-associations' }
FamixDiffComputer >> diffAssociations [
	(self changesDico values asSet asOrderedCollection
		"sorted: [ :a :b | a printString <= b printString ]")
		do: [ :chg | chg updateDiffForAssociations: self ]
		"displayingProgress: 'Comparing entity associations'"
]

{ #category : #'run-entities' }
FamixDiffComputer >> diffEntities [

	| baseTodo targetTodo |
	"loops on this block"
	[ 
	baseTodo := (self topEntitiesToMatch: self baseModel) asOrderedCollection.
	targetTodo := (self topEntitiesToMatch: self targetModel) asOrderedCollection.

	"as soon as one return true, go to next loop iteration"
	(self identityMatchesFrom: baseTodo to: targetTodo) or: [ 
		(self renameMatchesFrom: baseTodo to: targetTodo) or: [ (self moveMatchesFrom: baseTodo) or: [ self moveMatchesTo: targetTodo ] ] ] ] whileTrue.

	"Each entities in base model that couldn't be matched with entity in target model is considered as removed."
	(self entitiesToMatch: self baseModel) do: [ :e | self changesDico at: e put: (self makeChange: FamixRemovalChange with: e) ].

	"Each entities in target model that couldn't be matched with entity in base model is considered as added."
	(self entitiesToMatch: self targetModel) do: [ :e | self changesDico at: e put: (self makeChange: FamixAddChange with: e) ]
]

{ #category : #'run-entities' }
FamixDiffComputer >> entitiesToMatch: aModel [
	"not stub, not matched entities"
	^ aModel entities select: [:e | self entityToMatch: e ]

]

{ #category : #'run-entities' }
FamixDiffComputer >> entityToMatch: entity [
	"not stub, not matched"
	^ entity isNotNil
		and: [ (entity shouldBeConsideredForDiff) 
		and: [ (self matched: entity) not ] ]
]

{ #category : #'matching-entities' }
FamixDiffComputer >> identityMatchesFrom: baseEntities to: targetEntities [

	"Find the entities that are exactly the same between base version and target version (using #identityMatch:givenChanges: message).
	 If there is a match, a FamixVersionChange is created and stored."

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity identityMatch: targetEntity givenChanges: self changesDico ]
		  from: baseEntities
		  to: targetEntities
		  ifMatch: [ :baseEntity :targetEntity | 
			  | match |
			  targetEntities remove: targetEntity.
			  match := self makeChange: FamixVersionChange with: baseEntity with: targetEntity.
			  self changesDico
				  at: baseEntity put: match;
				  at: targetEntity put: match ]
		  progressMessage: 'Comparing two versions'
]

{ #category : #initialization }
FamixDiffComputer >> initialize [
	super initialize.
	changes := Dictionary new.
	assocChanges := OrderedCollection new
]

{ #category : #'change-creation' }
FamixDiffComputer >> makeChange: changeClass with: entity [
	^ changeClass new
			entity: entity
			yourself.

]

{ #category : #'change-creation' }
FamixDiffComputer >> makeChange: changeClass with: baseEntity with: targetEntity [
	^ changeClass new
			baseEntity: baseEntity ;
			targetEntity: targetEntity ;
			yourself.

]

{ #category : #testing }
FamixDiffComputer >> matched: entity [
	^ self changesDico includesKey: entity
]

{ #category : #'matching-entities' }
FamixDiffComputer >> matches: matchblock from: baseEntities to: targetEntities ifMatch: ifMatchBlock progressMessage: aString [

	"Find matches defined by matchblock (returns true -> match) between baseEntities and targetEntities.
	 matchblock takes 2 parameters: first is baseEntity, second is targetEntity being compared.
	
	 When a match is found, ifMatchBlock is evaluated with the base entity as first parameter and the target entity as second parameter.
	 The progress message is displayed by the UI during the computation.
	
	 This algorithm essentially takes each entity from baseEntities and try to match them with an entity in targetEntity list."

	| matchFound |
	matchFound := false.
	baseEntities
		do: [ :baseEntity | 
			targetEntities detect: [ :targetEntity | matchblock value: baseEntity value: targetEntity ] ifOne: [ :targetEntity | 
				ifMatchBlock value: baseEntity value: targetEntity.
				matchFound := true ] ]
		displayingProgress: aString.
	^ matchFound
]

{ #category : #'run-entities' }
FamixDiffComputer >> moveCandidates: aModel [
	"not stub, not matched entities"
	^ self entitiesToMatch: aModel
]

{ #category : #'matching-entities' }
FamixDiffComputer >> moveMatchesFrom: entities [

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity moveMatch: targetEntity givenChanges: self changesDico tolerance: self tolerance ]
		  from: entities
		  to: (self moveCandidates: self targetModel)
		  ifMatch: [ :baseEntity :targetEntity | 
			  | match |
			  match := self makeChange: FamixMoveChange with: baseEntity with: targetEntity.
			  self changesDico
				  at: baseEntity put: match;
				  at: targetEntity put: match ]
		  progressMessage: 'Computing modifications'
]

{ #category : #'matching-entities' }
FamixDiffComputer >> moveMatchesTo: targetEntities [

	^ self
		  matches: [ :baseEntity :targetEntity | targetEntity moveMatch: baseEntity givenChanges: self changesDico tolerance: self tolerance ]
		  from: (self moveCandidates: self baseModel)
		  to: targetEntities
		  ifMatch: [ :baseEntity :targetEntity | 
			  | match |
			  match := self makeChange: FamixMoveChange with: baseEntity with: targetEntity.
			  self changesDico
				  at: baseEntity put: match;
				  at: targetEntity put: match ]
		  progressMessage: 'Computing modifications'
]

{ #category : #'matching-entities' }
FamixDiffComputer >> renameMatchesFrom: baseEntities to: targetEntities [

	"Find the entities that have been renamed between base version and target version (using #renameMatch:givenChanges:tolerance: message).
	 If there is a match, a FamixRenameChange is created and stored."

	^ self
		  matches: [ :eBase :eTarget | eBase renameMatch: eTarget givenChanges: self changesDico tolerance: self tolerance ]
		  from: baseEntities
		  to: targetEntities
		  ifMatch: [ :eBase :eTarget | 
			  | match |
			  match := self makeChange: FamixRenameChange with: eBase with: eTarget.
			  self changesDico
				  at: eBase put: match;
				  at: eTarget put: match ]
		  progressMessage: 'Computing renamed entities'
]

{ #category : #'run-entities' }
FamixDiffComputer >> topEntitiesToMatch: aModel [
	"topmost, not stub, not matched entities"
	^ (self entitiesToMatch: aModel)
		select: [:e ||parent|
				parent := e belongsTo.
				(self entityToMatch: parent) not or: [self matched: parent] ]

]
