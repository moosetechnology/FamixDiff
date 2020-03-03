"
I represent an operation that can be applied for diff computing through the orchestrator.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	orchestrator:		<Object>


    Implementation Points
"
Class {
	#name : #FamixDiffAbstract,
	#superclass : #Object,
	#instVars : [
		'orchestrator'
	],
	#category : 'Famix-Diff-Core'
}

{ #category : #accessing }
FamixDiffAbstract >> argAt: aString [
	^ self orchestrator argAt: aString
]

{ #category : #accessing }
FamixDiffAbstract >> argAt: aString ifAbsent: anAbsentBlock [
	^ self orchestrator argAt: aString  ifAbsent: anAbsentBlock
]

{ #category : #accessing }
FamixDiffAbstract >> base [
	self
		deprecated: 'Use baseModel instead'
		on: '17 November 2016'
		in: 'Pharo-6.0-60294-'
		transformWith: '`@receiver base' -> '`@receiver baseModel'.
	^ self baseModel
]

{ #category : #accessing }
FamixDiffAbstract >> baseModel [
	^self orchestrator baseModel
]

{ #category : #accessing }
FamixDiffAbstract >> changes [
	^ self orchestrator result entityChanges
]

{ #category : #accessing }
FamixDiffAbstract >> orchestrator [
	^ orchestrator
]

{ #category : #accessing }
FamixDiffAbstract >> orchestrator: anObject [
	orchestrator := anObject
]

{ #category : #accessing }
FamixDiffAbstract >> result [
	^ self orchestrator result
]

{ #category : #accessing }
FamixDiffAbstract >> result: aFamixDiffResult [ 
	self orchestrator result: aFamixDiffResult
]

{ #category : #deprecated }
FamixDiffAbstract >> target [
	self 
		deprecated: 'Use targetModel instead'
		on: 	'17 November 2016' 
		in: 'Pharo-6.0-60294-'
		transformWith: '`@receiver target' -> '`@receiver targetModel'..
	^ self targetModel
]

{ #category : #accessing }
FamixDiffAbstract >> targetModel [
	^ self orchestrator targetModel
]

{ #category : #accessing }
FamixDiffAbstract >> tolerance [
	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	^ self orchestrator tolerance
]
