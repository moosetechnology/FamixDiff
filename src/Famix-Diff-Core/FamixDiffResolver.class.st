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
	#name : 'FamixDiffResolver',
	#superclass : 'Object',
	#instVars : [
		'changes',
		'orchestrator',
		'associationChanges'
	],
	#category : 'Famix-Diff-Core',
	#package : 'Famix-Diff-Core'
}

{ #category : 'accessing' }
FamixDiffResolver class >> generatedPackageName [
	"In order to speed up FamixDiff we are generating some code. Here is the name of the package that will contain this code."

	^ 'FamixDiff-Temporary-Generated-Package'
]

{ #category : 'accessing' }
FamixDiffResolver class >> generatedPackageProtocol [

	^ '*' , self generatedPackageName
]

{ #category : 'run-associations' }
FamixDiffResolver >> addAssociations: asociations [

	asociations do: [ :association | 
		self associationChanges add: (FamixAddChange new
				 entity: association;
				 yourself) ]
]

{ #category : 'run-entities' }
FamixDiffResolver >> addedEntitiesFrom: targetEntities [
	"Each entities in target model that couldn't be matched with entity in base model is considered as added."

	targetEntities ifEmpty: [ ^ false ].

	targetEntities do: [ :entity | self changes at: entity put: (FamixAddChange entity: entity) ].

	^ true
]

{ #category : 'accessing' }
FamixDiffResolver >> associationChanges [
	^ associationChanges
]

{ #category : 'accessing' }
FamixDiffResolver >> baseModel [
	^self orchestrator baseModel
]

{ #category : 'accessing' }
FamixDiffResolver >> changes [

	^ changes
]

{ #category : 'run-associations' }
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

{ #category : 'run' }
FamixDiffResolver >> computeDiff [
	"Compute the diff between the #base MooseModel and the #target MooseModel."

	[
		self computeDiffBetweenEntities.
		self result addAll: self changes values asSet.
		self computeDiffBetweenAssociations.
		self result addAll: self associationChanges asSet
	]
		ensure: [ self removeFamixDiffCaches ]
]

{ #category : 'run-associations' }
FamixDiffResolver >> computeDiffBetweenAssociations [

	self result do: [ :chg | chg updateDiffForAssociations: self ] displayingProgress: 'Comparing entity associations'
]

{ #category : 'run-entities' }
FamixDiffResolver >> computeDiffBetweenEntities [

	[ :job |
		"loops on this block"
		job max: self baseModel entities size.
		[
			[
				self updateProgressBarOf: job.
				self matchTopLevelEntities
			] whileTrue.
			self updateProgressBarOf: job.
			self lookForMovedEntitiesInUnmatchedEntities
		] whileTrue.

		self updateProgressBarOf: job.
		self recordAddRemoveChanges
	] asJob run
]

{ #category : 'run-associations' }
FamixDiffResolver >> delAssociations: assocs [
	assocs
		do: [ :a | 
			self associationChanges
				add:
					(FamixRemovalChange new
						entity: a;
						yourself) ]
]

{ #category : 'run-entities' }
FamixDiffResolver >> entitiesToMatchIn: aModel [

	"not stub, not matched entities"

	^ aModel entities select: [ :e | self shouldMatch: e ]
]

{ #category : 'run-entities' }
FamixDiffResolver >> findIdentityMatchesFrom: baseEntities to: targetEntities [
	"Find the entities that are exactly the same between base version and target version (using #identityMatch:resolver: message).
	 If there is a match, a FamixUnchangedChange is created and stored."

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity identityMatch: targetEntity resolver: self ]
		  from: baseEntities
		  to: targetEntities
		  changeType: FamixUnchangedChange
]

{ #category : 'run-entities' }
FamixDiffResolver >> findMoveMatchesFrom: baseEntities to: targetEntities [

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity moveMatch: targetEntity resolver: self ]
		  from: baseEntities
		  to: targetEntities
		  changeType: FamixMoveChange
]

{ #category : 'run-entities' }
FamixDiffResolver >> findRenameMatchesFrom: baseEntities to: targetEntities [
	"Find the entities that have been renamed between base version and target version (using #renameMatch:resolver: message).
	 If there is a match, a FamixRenameChange is created and stored."

	^ self
		  matches: [ :baseEntity :targetEntity | baseEntity renameMatch: targetEntity resolver: self ]
		  from: baseEntities
		  to: targetEntities
		  changeType: FamixRenameChange
]

{ #category : 'testing' }
FamixDiffResolver >> hasParentMatched: entity [
	"Return true only if the parents of the entity are already matched.
	
	We use #parentsDo: instead of #parents because this is faster."

	entity containersDo: [ :parent | ((self shouldMatch: parent) not or: [ self matched: parent ]) ifFalse: [ ^ false ] ].

	^ true
]

{ #category : 'testing' }
FamixDiffResolver >> hasParentMatched: entity ignoringParentsIn: aCollection [

	entity parentsDo: [ :parent | ((aCollection includes: parent) or: [ (self shouldMatch: parent) not or: [ self matched: parent ] ]) ifFalse: [ ^ false ] ].

	^ true
]

{ #category : 'initialization' }
FamixDiffResolver >> initialize [
	super initialize.
	changes := Dictionary new.
	associationChanges := OrderedCollection new
]

{ #category : 'testing' }
FamixDiffResolver >> is: baseEntity sameAs: targetEntity [

	"The method has the prerequisite that both given entities should already be treated by the resolver and be part of the changes dictionary. If one is not present we consider it was not present in one of the versions and thus they cannot be the same.
	
	Also, if one of them is a stub we cannot really compare so we just match the moose name."

	(changes at: baseEntity ifAbsent: [ #unknown ]) = (changes at: targetEntity ifAbsent: [ #unknown2 ]) ifTrue: [ ^ true ].

	(baseEntity isStub or: [ targetEntity isStub ]) ifTrue: [ ^ baseEntity mooseName = targetEntity mooseName ].

	^ false
]

{ #category : 'run-entities' }
FamixDiffResolver >> lookForMovedEntitiesInUnmatchedEntities [

	| unmatchedBasedEntities unmatchedTargetEntities |
	unmatchedBasedEntities := self topEntitiesToMatchIn: self baseModel.
	unmatchedTargetEntities := self topEntitiesToMatchIn: self targetModel.
	[
	| baseTodo targetTodo |
	baseTodo := self topEntitiesToMatchIn: self baseModel ignoringParentsIn: unmatchedBasedEntities.
	targetTodo := self topEntitiesToMatchIn: self targetModel ignoringParentsIn: unmatchedTargetEntities.

	((self findMoveMatchesFrom: baseTodo to: unmatchedTargetEntities) or: [
		 (self findMoveMatchesFrom: baseTodo to: targetTodo) or: [ self findMoveMatchesFrom: unmatchedBasedEntities to: targetTodo ] ]) ifTrue: [ ^ true ].

	unmatchedBasedEntities addAll: baseTodo.
	unmatchedTargetEntities addAll: targetTodo.

	baseTodo isEmpty or: [ targetTodo isEmpty ] ] whileFalse.

	^ false
]

{ #category : 'run-entities' }
FamixDiffResolver >> matchTopLevelEntities [
	"Tries to find some match between top level entities (those with parent matched, but not matched themselves)
	 return whether it could create new matches or not"

	| baseTodo targetTodo |

	baseTodo := self topEntitiesToMatchIn: self baseModel.
	targetTodo := self topEntitiesToMatchIn: self targetModel.

	^(self findIdentityMatchesFrom: baseTodo to: targetTodo) or:
		[ (self findRenameMatchesFrom: baseTodo to: targetTodo) or:
		[ self findMoveMatchesFrom: baseTodo to: targetTodo ] ]

]

{ #category : 'testing' }
FamixDiffResolver >> matched: entity [
	^ self changes includesKey: entity
]

{ #category : 'run-entities' }
FamixDiffResolver >> matches: matchblock from: baseEntities to: targetEntities changeType: aChangeClass [
	"Find matches defined by matchblock (returns true -> match) between baseEntities and targetEntities.
	 When a match is found, aChangeClass instance is created and added to the change dictionary.
	 This algorithm essentially takes each entity from baseEntities and try to match them with an entity in targetEntity list."

	| matchFound |
	matchFound := false.
	baseEntities do: [ :baseEntity |
		targetEntities
			detect: [ :targetEntity | matchblock value: baseEntity value: targetEntity ]
			ifFound: [ :targetEntity |
				| match |
				targetEntities remove: targetEntity.
				match := aChangeClass base: baseEntity target: targetEntity.
				self changes
					at: baseEntity put: match;
					at: targetEntity put: match.
				matchFound := true ] ].
	^ matchFound
]

{ #category : 'accessing' }
FamixDiffResolver >> orchestrator [
	^ orchestrator
]

{ #category : 'accessing' }
FamixDiffResolver >> orchestrator: anObject [
	orchestrator := anObject
]

{ #category : 'run-entities' }
FamixDiffResolver >> recordAddRemoveChanges [
	"Each entity in target model that couldn't be matched to an entity in base model is considered added.
	 Each entity in base model that couldn't be matched to an entity in target model is considered removed."

	(self entitiesToMatchIn: self targetModel) do: [ :entity |
		self changes at: entity put: (FamixAddChange entity: entity) ].

	(self entitiesToMatchIn: self baseModel) do: [ :entity |
	  self changes at: entity put: (FamixRemovalChange entity: entity) ]
]

{ #category : 'private' }
FamixDiffResolver >> removeFamixDiffCaches [
	"FamixDiff will generate some methods to speed up the diff computation process. Here we remove the generated code because we do not want to poluate the image.
	For more info see TEntityMetaLevelDependency>>#identityMatch:resolver:.
	
	We also remove some other caches."

	self packageOrganizer packageNamed: self class generatedPackageName ifPresent: [ :package | package removeFromSystem ].
	(self baseModel allUsing: FamixTComment) do: [ :comment | comment removeCache: #sourceTextHash ].
	(self targetModel allUsing: FamixTComment) do: [ :comment | comment removeCache: #sourceTextHash ]
]

{ #category : 'run-entities' }
FamixDiffResolver >> removedEntitiesFrom: baseEntities [
	"Each entities in base model that couldn't be matched with entity in target model is considered as removed."

	baseEntities ifEmpty: [ ^ false ].

	baseEntities do: [ :entity | self changes at: entity put: (FamixRemovalChange entity: entity) ].

	^ true
]

{ #category : 'accessing' }
FamixDiffResolver >> result [
	^ self orchestrator result
]

{ #category : 'accessing' }
FamixDiffResolver >> result: aFamixDiffResult [ 
	self orchestrator result: aFamixDiffResult
]

{ #category : 'testing' }
FamixDiffResolver >> shouldConsiderComments [

	^ self orchestrator shouldConsiderComments
]

{ #category : 'testing' }
FamixDiffResolver >> shouldMatch: entity [
	"Return true if I still need to find the match for the entity as parameter"

	(entity isQueryable and: [ entity isComment and: [ self shouldConsiderComments not ] ]) ifTrue: [ ^ false ].

	^ entity shouldBeConsideredForDiff and: [ (self matched: entity) not ]
]

{ #category : 'accessing' }
FamixDiffResolver >> targetModel [
	^ self orchestrator targetModel
]

{ #category : 'accessing' }
FamixDiffResolver >> tolerance [
	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	^ self orchestrator tolerance
]

{ #category : 'accessing' }
FamixDiffResolver >> tolerance: anInteger [

	orchestrator tolerance: anInteger
]

{ #category : 'run-entities' }
FamixDiffResolver >> topEntitiesToMatchIn: aModel [

	^ (self entitiesToMatchIn: aModel) select: [ :entity | self hasParentMatched: entity ]
]

{ #category : 'run-entities' }
FamixDiffResolver >> topEntitiesToMatchIn: aModel ignoringParentsIn: aCollection [

	^ (self entitiesToMatchIn: aModel) select: [ :entity |
		  (aCollection includes: entity) not and: [ self hasParentMatched: entity ignoringParentsIn: aCollection ] ]
]

{ #category : 'run-entities' }
FamixDiffResolver >> updateProgressBarOf: job [

	| entitiesToMatchSize |
	entitiesToMatchSize := (self entitiesToMatchIn: self baseModel) size.

	job
		label: 'Diff computation in progress. ' , entitiesToMatchSize asString , ' left out of ' , job max asString;
		currentValue: job max - entitiesToMatchSize
]
