"
I represent a move change.

A move change means that the baseEntity location is different from the location of the targetEntity.

I answer true to #isMove.
"
Class {
	#name : #FamixMoveChange,
	#superclass : #FamixPairedChange,
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixMoveChange class >> changeName [
	^ 'Moved'
]

{ #category : #visiting }
FamixMoveChange >> accept: aVisitor [
	aVisitor visitMoveChange: self
]

{ #category : #testing }
FamixMoveChange >> isMove [

	^true
]

{ #category : #printing }
FamixMoveChange >> printOn: stream [
	super printOn: stream.
	stream
		<< ' -> ';
		<< self targetEntity mooseName
]
