"
I represent a body change.

A body change means that the baseEntity body is different from the targetEntity body. For a method, it means that the source code of the method has been changed.

I answer true to #isBody.
"
Class {
	#name : #FamixBodyChange,
	#superclass : #FamixPairedChange,
	#category : 'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixBodyChange class >> changeName [
	^ 'bod'
]

{ #category : #visiting }
FamixBodyChange >> accept: aVisitor [
	aVisitor visitBodyChange: self
]

{ #category : #testing }
FamixBodyChange >> isBody [
	^ true
]

{ #category : #printing }
FamixBodyChange >> printOn: stream [
	super printOn: stream.
	stream
		<< ' -> ';
		<< self targetEntity mooseName
]
