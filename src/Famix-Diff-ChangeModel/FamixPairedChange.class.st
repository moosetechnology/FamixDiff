"
I am an abstract class for a change that concern an entity in the source model and an entity of the target model of the diff.

I answer true to #isMatch.

For coherence purpose, I implement #baseEntity and #baseEntity: accessor and mutator that manipulate the entity inst. var inherited from FamixChange.
To access/set the target entity, I define #targetEntity and #targetEntity: messages.
"
Class {
	#name : #FamixPairedChange,
	#superclass : #FamixChange,
	#instVars : [
		'targetEntity'
	],
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixPairedChange class >> changeName [
	^ 'modif'
]

{ #category : #comparing }
FamixPairedChange >> = anObject [
	^ super = anObject and: [ 
		anObject targetEntity = self targetEntity ]
]

{ #category : #visiting }
FamixPairedChange >> accept: aVisitor [
	aVisitor visitPairedChange: self
]

{ #category : #accessing }
FamixPairedChange >> baseEntityName [
	^ self baseEntity name
]

{ #category : #comparing }
FamixPairedChange >> hash [
	^ (super hash bitXor: self targetEntity hash) bitXor: self targetEntityName hash
]

{ #category : #testing }
FamixPairedChange >> isMatch [

	^true
]

{ #category : #accessing }
FamixPairedChange >> targetEntity [
	^ targetEntity
]

{ #category : #accessing }
FamixPairedChange >> targetEntity: anEntity [
	targetEntity := anEntity
					
]

{ #category : #accessing }
FamixPairedChange >> targetEntityName [
	^ self targetEntity name
]
