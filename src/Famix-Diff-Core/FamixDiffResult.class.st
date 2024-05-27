"
I contain the results of the diff made on 2 models.

"
Class {
	#name : #FamixDiffResult,
	#superclass : #MooseGroup,
	#category : #'Famix-Diff-Core'
}

{ #category : #accessing }
FamixDiffResult >> additionChanges [

	^ self select: [ :change | change isAddition ]
]

{ #category : #accessing }
FamixDiffResult >> allChanges [

	<navigation: 'All changes'>
	^ self
]

{ #category : #accessing }
FamixDiffResult >> associationChanges [

	<navigation: 'All associationChanges'>
	^ self select: [ :change | change isForAssociation ]
]

{ #category : #private }
FamixDiffResult >> changeTypeToDefaultType [
	self changeTypeTo: FamixDiffResult
]

{ #category : #accessing }
FamixDiffResult >> entityChanges [

	<navigation: 'All entity changes'>
	^ self reject: [ :change | change isForAssociation ]
]

{ #category : #accessing }
FamixDiffResult >> realChanges [
	"I return all the changes actually representing a change, rejecting identical changes."

	^ self reject: [ :change | change isUnchanged ]
]

{ #category : #accessing }
FamixDiffResult >> removalChanges [

	^ self select: [ :change | change isRemoval ]
]

{ #category : #private }
FamixDiffResult >> species [

	^ self class
]

{ #category : #accessing }
FamixDiffResult >> withoutStubs [
	"Returns all the results without the stubs"

	^ self reject: [ :change | change entity isStub ]
]
