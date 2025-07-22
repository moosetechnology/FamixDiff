"
Indicates that targetEntity is a version of entity
so actually it is not a change
"
Class {
	#name : 'FamixUnchangedChange',
	#superclass : 'FamixPairedChange',
	#category : 'Famix-Diff-ChangeModel',
	#package : 'Famix-Diff-ChangeModel'
}

{ #category : 'accessing' }
FamixUnchangedChange class >> changeName [

	^ 'Identity'
]

{ #category : 'visiting' }
FamixUnchangedChange >> accept: aVisitor [
	aVisitor visitUnchangedChange: self
]

{ #category : 'testing' }
FamixUnchangedChange >> isUnchanged [
	^ true
]
