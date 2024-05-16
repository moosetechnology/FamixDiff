"
I am a change that represents the removal of an entity.

I answer true to #isRemoval.
"
Class {
	#name : #FamixRemovalChange,
	#superclass : #FamixChange,
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixRemovalChange class >> changeName [
	^ 'Deletion'
]

{ #category : #visiting }
FamixRemovalChange >> accept: aVisitor [
	aVisitor visitRemovalChange: self
]

{ #category : #testing }
FamixRemovalChange >> isRemoval [

	^true
]
