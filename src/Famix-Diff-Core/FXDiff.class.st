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
	#superclass : #Object,
	#instVars : [
		'baseModel',
		'result',
		'targetModel',
		'tolerance',
		'diffComputer'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #'instance creation' }
FXDiff class >> baseModel: aBaseModel targetModel: targetModel [

	^ self new
		  baseModel: aBaseModel;
		  targetModel: targetModel;
		  yourself
]

{ #category : #running }
FXDiff class >> runOnBaseModel: aBaseModel targetModel: aTargetModel [
	^ (self baseModel: aBaseModel targetModel: aTargetModel) run
]

{ #category : #accessing }
FXDiff >> associationChanges [
	^ self result associationChanges
]

{ #category : #accessing }
FXDiff >> baseModel [
	^ baseModel
]

{ #category : #accessing }
FXDiff >> baseModel: aBaseModel [

	baseModel := aBaseModel
]

{ #category : #accessing }
FXDiff >> changes: aCollection [
	^ self result changes: aCollection
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

{ #category : #initialization }
FXDiff >> initialize [

	super initialize.
	tolerance := 0.2.
	result := FamixDiffResult new.
	diffComputer := FamixDiffResolver new
		                orchestrator: self;
		                yourself
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
FXDiff >> run [

	self assert: (self baseModel isKindOf: MooseModel).
	self assert: (self targetModel isKindOf: MooseModel).
	diffComputer diff
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
