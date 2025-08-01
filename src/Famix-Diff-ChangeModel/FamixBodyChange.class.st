"
I represent a body change.

A body change means that the baseEntity body is different from the targetEntity body. For a method, it means that the source code of the method has been changed.

I answer true to #isBody.
"
Class {
	#name : 'FamixBodyChange',
	#superclass : 'FamixPairedChange',
	#category : 'Famix-Diff-ChangeModel',
	#package : 'Famix-Diff-ChangeModel'
}

{ #category : 'accessing' }
FamixBodyChange class >> changeName [
	^ 'BodyChange'
]

{ #category : 'visiting' }
FamixBodyChange >> accept: aVisitor [
	aVisitor visitBodyChange: self
]

{ #category : 'testing' }
FamixBodyChange >> isBody [
	^ true
]
