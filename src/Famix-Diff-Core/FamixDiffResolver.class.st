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
	#name : #FamixDiffResolver,
	#superclass : #Object,
	#instVars : [
		'changes',
		'assocChanges',
		'orchestrator'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #accessing }
FamixDiffResolver class >> generatedPackageName [
	"In order to speed up FamixDiff we are generating some code. Here is the name of the package that will contain this code."

	^ 'FamixDiff-Temporary-Generated-Package'
]

{ #category : #accessing }
FamixDiffResolver class >> generatedPackageProtocol [

	^ '*' , self generatedPackageName
]

{ #category : #'run-associations' }
FamixDiffResolver >> addAssociations: asociations [

	asociations do: [ :association | 
		self associationChanges add: (FamixAddChange new
				 entity: association;
				 yourself) ]
]

{ #category : #'run-entities' }
FamixDiffResolver >> addedEntitiesFrom: targetEntities [
	"Each entities in target model that couldn't be matched with entity in base model is considered as added."

	targetEntities ifEmpty: [ ^ false ].

	targetEntities do: [ :entity | self changesDico at: entity put: (FamixAddChange entity: entity) ].

	^ true
]

{ #category : #accessing }
FamixDiffResolver >> assocChanges: aCollection [
	^ assocChanges := aCollection
]

{ #category : #accessing }
FamixDiffResolver >> associationChanges [
	^ assocChanges
]

{ #category : #accessing }
FamixDiffResolver >> baseModel [
	^self orchestrator baseModel
]

{ #category : #accessing }
FamixDiffResolver >> changes [

	^ changes
]

{ #category : #accessing }
FamixDiffResolver >> changesDico [
	^ changes
]

{ #category : #accessing }
FamixDiffResolver >> changesDico: aCollection [
	changes := aCollection
]

{ #category : #'run-associations' }
FamixDiffResolver >> checkAssocsMatches: baseAssocs with: targetAssocs [

	baseAssocs do: [ :baseAss | 
		targetAssocs
			detect: [ :targetAss | targetAss matches: baseAss resolver: self ]
			ifOne: [ :found | targetAssocs remove: found ]
			ifNone: [ "not creating FAMIXMatchChange for associations"
				self associationChanges add: (FamixRemovalChange new
						 entity: baseAss;
						 yourself) ] ].
	self addAssociations: targetAssocs
]

{ #category : #'run-associations' }
FamixDiffResolver >> delAssociations: assocs [
	assocs
		do: [ :a | 
			self associationChanges
				add:
					(FamixRemovalChange new
						entity: a;
						yourself) ]
]

{ #category : #run }
FamixDiffResolver >> diff [
	"Compute the diff between the #base MooseModel and the #target MooseModel."

	[
	self diffEntities.
	self diffAssociations.
	self result addAll: self changesDico values asSet.
	self result addAll: self associationChanges asSet ] ensure: [ self removeFamixDiffCaches ]
]

{ #category : #'run-associations' }
FamixDiffResolver >> diffAssociations [

	self changesDico values asSet do: [ :chg | chg updateDiffForAssociations: self ] displayingProgress: 'Comparing entity associations'
]

{ #category : #'run-entities' }
FamixDiffResolver >> diffEntities [

	[ :job |
	job max: self baseModel entities size.
	"loops on this block"
	[
	self updateProgressBarOf: job.
	self findNextIdentitiesRenamingsOrMovedEntities.

	self updateProgressBarOf: job.

	self lookForMovedEntitiesInUnmatchedEntities or: [
		self updateProgressBarOf: job.
		self lookForAddedAndRemovedEntities ] ] whileTrue ] asJob run
]

{ #category : #'run-entities' }
FamixDiffResolver >> entitiesToMatchIn: aModel [

	"not stub, not matched entities"

	^ aModel entities select: [ :e | self shouldMatch: e ]
]

{ #category : #'run-entities' }
FamixDiffResolver >> findNextIdentitiesRenamingsOrMovedEntities [

	[
	| baseTodo targetTodo |
	baseTodo := self topEntitiesToMatchIn: self baseModel.
	targetTodo := self topEntitiesToMatchIn: self targetModel.

	"as soon as one return true, go to next loop iteration"
	(self identityMatchesFrom: baseTodo to: targetTodo) or: [
		(self renameMatchesFrom: baseTodo to: targetTodo) or: [ self moveMatchesFrom: baseTodo to: targetTodo ] ] ] whileTrue
]

{ #category : #testing }
FamixDiffResolver >> hasParentMatched: entity [
	"Return true only if the parents of the entity are already matched.
	
	We use #parentsDo: instead of #parents because this is faster."

	entity parentsDo: [ :parent | ((self shouldMatch: parent) not or: [ self matched: parent ]) ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #'run-entities' }
FamixDiffResolver >> identityMatchesFrom: baseEntities to: targetEntities [
	"Find the entities that are exactly the same between base version and target version (using #identityMatch:resolver: message).
	 If there is a match, a FamixUnchangedChange is created and stored."

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity identityMatch: targetEntity resolver: self ]
		  from: baseEntities
		  to: targetEntities
		  ifMatch: [ :baseEntity :targetEntity |
			  | match |
			  targetEntities remove: targetEntity.
			  match := FamixUnchangedChange base: baseEntity target: targetEntity.
			  self changesDico
				  at: baseEntity put: match;
				  at: targetEntity put: match ]
]

{ #category : #initialization }
FamixDiffResolver >> initialize [
	super initialize.
	changes := Dictionary new.
	assocChanges := OrderedCollection new
]

{ #category : #testing }
FamixDiffResolver >> is: baseEntity sameAs: targetEntity [

	"The method has the prerequisite that both given entities should already be treated by the resolver and be part of the changes dictionary. If one is not present we consider it was not present in one of the versions and thus they cannot be the same.
	
	Also, if one of them is a stub we cannot really compare so we just match the moose name."

	(changes at: baseEntity ifAbsent: [ #unknown ]) = (changes at: targetEntity ifAbsent: [ #unknown2 ]) ifTrue: [ ^ true ].

	(baseEntity isStub or: [ targetEntity isStub ]) ifTrue: [ ^ baseEntity mooseName = targetEntity mooseName ].

	^ false
]

{ #category : #'run-entities' }
FamixDiffResolver >> lookForAddedAndRemovedEntities [

	[
	| baseTodo targetTodo |
	baseTodo := self topEntitiesToMatchIn: self baseModel.
	targetTodo := self topEntitiesToMatchIn: self targetModel.
	(self addedEntitiesFrom: targetTodo) or: [ self removedEntitiesFrom: baseTodo ] ] whileTrue.

	^ false
]

{ #category : #'run-entities' }
FamixDiffResolver >> lookForMovedEntitiesInUnmatchedEntities [

	^ self moveMatchesFrom: (self entitiesToMatchIn: self baseModel) to: (self entitiesToMatchIn: self targetModel)
]

{ #category : #testing }
FamixDiffResolver >> matched: entity [
	^ self changesDico includesKey: entity
]

{ #category : #'run-entities' }
FamixDiffResolver >> matches: matchblock from: baseEntities to: targetEntities ifMatch: ifMatchBlock [
	"Find matches defined by matchblock (returns true -> match) between baseEntities and targetEntities.
	 matchblock takes 2 parameters: first is baseEntity, second is targetEntity being compared.
	
	 When a match is found, ifMatchBlock is evaluated with the base entity as first parameter and the target entity as second parameter.
	 The progress message is displayed by the UI during the computation.
	
	 This algorithm essentially takes each entity from baseEntities and try to match them with an entity in targetEntity list."

	| matchFound |
	matchFound := false.
	baseEntities do: [ :baseEntity |
		targetEntities detect: [ :targetEntity | matchblock value: baseEntity value: targetEntity ] ifOne: [ :targetEntity |
			ifMatchBlock value: baseEntity value: targetEntity.
			matchFound := true ] ].
	^ matchFound
]

{ #category : #'run-entities' }
FamixDiffResolver >> moveMatchesFrom: baseEntities to: targetEntities [

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity moveMatch: targetEntity resolver: self ]
		  from: baseEntities
		  to: targetEntities
		  ifMatch: [ :baseEntity :targetEntity |
			  | match |
			  targetEntities remove: targetEntity.
			  match := FamixMoveChange base: baseEntity target: targetEntity.
			  self changesDico
				  at: baseEntity put: match;
				  at: targetEntity put: match ]
]

{ #category : #accessing }
FamixDiffResolver >> orchestrator [
	^ orchestrator
]

{ #category : #accessing }
FamixDiffResolver >> orchestrator: anObject [
	orchestrator := anObject
]

{ #category : #run }
FamixDiffResolver >> removeFamixDiffCaches [
	"FamixDiff will generate some methods to speed up the diff computation process. Here we remove the generated code because we do not want to poluate the image.
	For more info see TEntityMetaLevelDependency>>#identityMatch:resolver:"

	self packageOrganizer packageNamed: self class generatedPackageName ifPresent: [ :package | package removeFromSystem ]
]

{ #category : #'run-entities' }
FamixDiffResolver >> removedEntitiesFrom: baseEntities [
	"Each entities in base model that couldn't be matched with entity in target model is considered as removed."

	baseEntities ifEmpty: [ ^ false ].

	baseEntities do: [ :entity | self changesDico at: entity put: (FamixRemovalChange entity: entity) ].

	^ true
]

{ #category : #'run-entities' }
FamixDiffResolver >> renameMatchesFrom: baseEntities to: targetEntities [
	"Find the entities that have been renamed between base version and target version (using #renameMatch:resolver: message).
	 If there is a match, a FamixRenameChange is created and stored."

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity renameMatch: targetEntity resolver: self ]
		  from: baseEntities
		  to: targetEntities
		  ifMatch: [ :baseEntity :targetEntity |
			  | match |
			  targetEntities remove: targetEntity.
			  match := FamixRenameChange base: baseEntity target: targetEntity.
			  self changesDico
				  at: baseEntity put: match;
				  at: targetEntity put: match ]
]

{ #category : #accessing }
FamixDiffResolver >> result [
	^ self orchestrator result
]

{ #category : #accessing }
FamixDiffResolver >> result: aFamixDiffResult [ 
	self orchestrator result: aFamixDiffResult
]

{ #category : #testing }
FamixDiffResolver >> shouldMatch: entity [

	"Return true if I still need to find the match for the entity as parameter"

	^ entity isNotNil and: [ entity shouldBeConsideredForDiff and: [ (self matched: entity) not ] ]
]

{ #category : #accessing }
FamixDiffResolver >> targetModel [
	^ self orchestrator targetModel
]

{ #category : #accessing }
FamixDiffResolver >> tolerance [
	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	^ self orchestrator tolerance
]

{ #category : #accessing }
FamixDiffResolver >> tolerance: anInteger [

	orchestrator tolerance: anInteger
]

{ #category : #'run-entities' }
FamixDiffResolver >> topEntitiesToMatchIn: aModel [

	^ (self entitiesToMatchIn: aModel) select: [ :entity | self hasParentMatched: entity ]
]

{ #category : #'run-entities' }
FamixDiffResolver >> updateProgressBarOf: job [

	| entitiesToMatchSize |
	entitiesToMatchSize := (self entitiesToMatchIn: self baseModel) size.

	job
		label: 'Diff computation in progress. ' , entitiesToMatchSize asString , ' left out of ' , job max asString;
		currentValue: job max - entitiesToMatchSize
]
