"
Indicates that targetEntity is a version of entity
so actually it is not a change
"
Class {
	#name : #FamixUnchangedChange,
	#superclass : #FamixPairedChange,
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #visiting }
FamixUnchangedChange >> accept: aVisitor [
	aVisitor visitVersionChange: self
]

{ #category : #testing }
FamixUnchangedChange >> isVersion [
	^ true
]

{ #category : #printing }
FamixUnchangedChange >> printOn: stream [
	super printOn: stream.
	stream nextPutAll: ' ='
]
