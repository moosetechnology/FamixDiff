"
I orchestrate the computing of the diff of 2 models.  Base: MooseModel  or OrionModel; target MooseModel

I am the entry point class of the diff. I use a generator to compute a first pass of the diff (see subclasses of FAMIXDiffAbstractComputer) and transformers that transforms the diff results into more complex diff elements (see subclasses of FamixDiffAbstractTransformator).

I collaborate with FamixDiffAbstractTransformator, FamixDiffAbstractGenerator and FamixDiffResult.

Public API and Key Messages

- see class side for creation 
- #result to get the diff result

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	base:		Instance of MooseModel
	result:		FamixDiffResult
	diffComputer:		FAMIXDiffAbstractGenerator
	diffTransformers:		FamixDiffAbstractTransformator
	target:		MooseModel


    Implementation Points
"
Class {
	#name : #FXDiff,
	#superclass : #MooseOperator,
	#instVars : [
		'baseModel',
		'result',
		'targetModel',
		'diffComputer',
		'diffTransformers',
		'tolerance'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #'instance creation' }
FXDiff class >> baseModel: aBaseModel targetModel: aTargetModel [
	^ self baseModel: aBaseModel targetModel: aTargetModel diffComputer: FamixDiff
]

{ #category : #'instance creation' }
FXDiff class >> baseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer [
	^ self
		baseModel: aBaseModel
		targetModel: targetModel
		diffComputer: aDiffComputer
		diffTransformers: nil
]

{ #category : #'instance creation' }
FXDiff class >> baseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer diffTransformers: aColOfDiffTransformers [
	^ self new
		baseModel: aBaseModel;
		targetModel: targetModel;
		diffComputer: aDiffComputer;
		diffTransformers: aColOfDiffTransformers;
		yourself
]

{ #category : #'instance creation' }
FXDiff class >> baseModel: aBaseModel targetModel: targetModel diffTransformers: aColOfDiffTransformers [
	^ self new
		baseModel: aBaseModel;
		targetModel: targetModel;
		diffComputer: self defaultDiffComputer;
		diffTransformers: aColOfDiffTransformers;
		yourself
]

{ #category : #accessing }
FXDiff class >> defaultDiffComputer [
	^ FamixDiff
]

{ #category : #'instance creation' }
FXDiff class >> new [
	^ super new
		diffComputer: self defaultDiffComputer;
		yourself
]

{ #category : #running }
FXDiff class >> runOnBaseModel: aBaseModel targetModel: aTargetModel [
	^ (self baseModel: aBaseModel targetModel: aTargetModel) run
]

{ #category : #running }
FXDiff class >> runOnBaseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer diffTransformers: aColOfDiffTransformers [
	^ (self
		baseModel: aBaseModel
		targetModel: targetModel
		diffComputer: aDiffComputer
		diffTransformers: aColOfDiffTransformers) run
]

{ #category : #running }
FXDiff class >> runOnBaseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer diffTransformers: aColOfDiffTransformers args: aDicoOfArgs [
	^ (self
		baseModel: aBaseModel
		targetModel: targetModel
		diffComputer: aDiffComputer
		diffTransformers: aColOfDiffTransformers)
		args: aDicoOfArgs;
		run
]

{ #category : #'as yet unclassified' }
FXDiff >> assocChanges [
	^ self result assocChanges
]

{ #category : #deprecated }
FXDiff >> base [
	self
		deprecated: 'Please use #baseModel  instead'
		transformWith: '`@receiver base' 
						-> '`@receiver baseModel'.
	
	^ self baseModel
]

{ #category : #deprecated }
FXDiff >> base: aMooseModel [
	self deprecated: 'Please use #baseModel:  instead' transformWith: '`@receiver base: `@statements1' -> '`@receiver baseModel: `@statements1'.
	^ self baseModel: aMooseModel
]

{ #category : #accessing }
FXDiff >> baseModel [
	^ baseModel
]

{ #category : #accessing }
FXDiff >> baseModel: aBaseModel [
	aBaseModel prepareToDiff.
	baseModel := aBaseModel
]

{ #category : #private }
FXDiff >> basicRun [
	diffComputer diff.
	diffTransformers ifNotNil: [ self diffTransformers do: [ :aPostOperationClass | aPostOperationClass run ] ]
]

{ #category : #'as yet unclassified' }
FXDiff >> changes: aCollection [
	^ self result changes: aCollection
]

{ #category : #checking }
FXDiff >> checkDiffComputer [
	self assert: self diffComputer isNotNil
]

{ #category : #'as yet unclassified' }
FXDiff >> checkDiffTransformers [
	self flag: #TODO.
]

{ #category : #accessing }
FXDiff >> diffComputer [
	^ diffComputer
]

{ #category : #accessing }
FXDiff >> diffComputer: anObject [
	diffComputer := anObject new
		orchestrator: self;
		yourself
]

{ #category : #accessing }
FXDiff >> diffTransformers [
	^ diffTransformers
]

{ #category : #accessing }
FXDiff >> diffTransformers: aCollectionOfPostOperators [
	self assert: (aCollectionOfPostOperators isNil or: [ aCollectionOfPostOperators isCollection ]) description: 'PostOperators should be a collection...'.
	diffTransformers := aCollectionOfPostOperators
		ifNotNil: [ aCollectionOfPostOperators
				collect: [ :aClass | 
					aClass new
						orchestrator: self;
						yourself ] ]
]

{ #category : #initialization }
FXDiff >> initialize [
	super initialize.
	tolerance := 0.
	result := FamixDiffResult new orchestrator: self.
]

{ #category : #accessing }
FXDiff >> result [
	^ result
]

{ #category : #accessing }
FXDiff >> result: anObject [
	result := anObject
]

{ #category : #private }
FXDiff >> setUp [
	super setUp.
	self assert: (self baseModel isKindOf: MooseModel).
	self assert: (self targetModel isKindOf: MooseModel).
	self checkDiffComputer.
	self checkDiffTransformers.
]

{ #category : #accessing }
FXDiff >> target [
	self
		deprecated: 'Please use #targetModel  instead'
		transformWith: '`@receiver target' 
						-> '`@receiver targetModel'.
	
	^ self targetModel
]

{ #category : #deprecated }
FXDiff >> target: aMooseModel [ 

	self deprecated: 'Please use #targetModel:  instead' transformWith: '`@receiver target: `@statements1' -> '`@receiver targetModel: `@statements1'.
	^ self targetModel: aMooseModel
]

{ #category : #accessing }
FXDiff >> targetModel [
	^ targetModel
]

{ #category : #accessing }
FXDiff >> targetModel: anObject [
	targetModel := anObject
]

{ #category : #accessing }
FXDiff >> tolerance [
	^ tolerance
]

{ #category : #accessing }
FXDiff >> tolerance: anObject [
	tolerance := anObject
]
