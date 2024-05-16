"
I am able to visit any FamixChange and definied a behaviour belonging to the change traversed.
"
Class {
	#name : #FamixChangeVisitor,
	#superclass : #Object,
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #visiting }
FamixChangeVisitor >> visitAddChange: aAddChange [
	^ self visitChange: aAddChange
]

{ #category : #visiting }
FamixChangeVisitor >> visitBodyChange: aBodyChange [
	^ self visitPairedChange: aBodyChange
]

{ #category : #visiting }
FamixChangeVisitor >> visitChange: aChange [
	self subclassResponsibility
]

{ #category : #visiting }
FamixChangeVisitor >> visitMoveChange: aMoveChange [
	^ self visitPairedChange: aMoveChange
]

{ #category : #visiting }
FamixChangeVisitor >> visitPairedChange: aPairedChange [
	^ self visitChange: aPairedChange
]

{ #category : #visiting }
FamixChangeVisitor >> visitRemovalChange: aRemovalChange [
	^ self visitChange: aRemovalChange
]

{ #category : #visiting }
FamixChangeVisitor >> visitRenameChange: aRenameChange [
	^ self visitPairedChange: aRenameChange
]

{ #category : #visiting }
FamixChangeVisitor >> visitUnchangedChange: aVersionChange [
	^ self visitPairedChange: aVersionChange
]
