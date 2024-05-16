"
I am a change that represents the addition of an entity.

I answer true to #isAddition.
"
Class {
	#name : #FamixAddChange,
	#superclass : #FamixChange,
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixAddChange class >> changeName [

	^ 'Addition'
]

{ #category : #visiting }
FamixAddChange >> accept: aVisitor [
	aVisitor visitAddChange: self
]

{ #category : #testing }
FamixAddChange >> isAddition [

	^true
]
