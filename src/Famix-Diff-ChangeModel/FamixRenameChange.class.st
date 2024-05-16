"
I represent a rename change.

A rename change means that the baseEntity has been renamed and its name is different from the name of the targetEntity.

I answer true to #isRename.
"
Class {
	#name : #FamixRenameChange,
	#superclass : #FamixPairedChange,
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixRenameChange class >> changeName [
	^ 'Renaming'
]

{ #category : #visiting }
FamixRenameChange >> accept: aVisitor [
	aVisitor visitRenameChange: self
]

{ #category : #testing }
FamixRenameChange >> isRename [
	^ true
]

{ #category : #printing }
FamixRenameChange >> printOn: stream [
	super printOn: stream.
	stream
		<< ' -> ';
		<< self targetEntity name
]
