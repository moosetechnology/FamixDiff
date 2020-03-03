"
Indicates that targetEntity is a version of entity
so actually it is not a change
"
Class {
	#name : #FamixVersionChange,
	#superclass : #FamixPairedChange,
	#category : 'Famix-Diff-ChangeModel'
}

{ #category : #visiting }
FamixVersionChange >> accept: aVisitor [
	aVisitor visitVersionChange: self
]

{ #category : #testing }
FamixVersionChange >> isVersion [
	^ true
]

{ #category : #printing }
FamixVersionChange >> printOn: stream [
	super printOn: stream.
	stream nextPutAll: ' ='
]
