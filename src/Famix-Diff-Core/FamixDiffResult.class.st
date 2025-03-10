"
I contain the results of the diff made on 2 models.

"
Class {
	#name : #FamixDiffResult,
	#superclass : #MooseGroup,
	#category : #'Famix-Diff-Core'
}

{ #category : #accessing }
FamixDiffResult >> additions [
	"Returns all changes corresponding to the addition of an entity in the target model."

	^ self select: [ :change | change isAddition ]
]

{ #category : #accessing }
FamixDiffResult >> allChanges [
	"Returns all changes. Present mostly to have the navigation pragma."

	<navigation: 'All changes'>
	^ self
]

{ #category : #accessing }
FamixDiffResult >> associationChanges [
	"Returns all changes affecting an association and not entities."

	<navigation: 'All associationChanges'>
	^ self select: [ :change | change isForAssociation ]
]

{ #category : #private }
FamixDiffResult >> changeTypeToDefaultType [

	self changeTypeTo: self class
]

{ #category : #accessing }
FamixDiffResult >> entityChanges [
	"Returns all changes corresponding to entities and not associations."

	<navigation: 'All entity changes'>
	^ self reject: [ :change | change isForAssociation ]
]

{ #category : #accessing }
FamixDiffResult >> groupAdditionsAndRemovalsByRoots [
	"When entities are not found in the base or target model we create additions and removals. This API method return a new set of changes that keeps only the top level additions and removals. If we add a package for example it will remove all its added classes methods and variables to keep a high level view of the changes."

	^ self select: [ :change |
		  change entity isAssociation not and: [
			  (change isAddition and: [ change entity parents noneSatisfy: [ :parent | self additions anySatisfy: [ :change2 | change2 entity = parent ] ] ]) or: [
				  change isRemoval and: [ change entity parents noneSatisfy: [ :parent | self removals anySatisfy: [ :change2 | change2 entity = parent ] ] ] ] ] ]
]

{ #category : #accessing }
FamixDiffResult >> identities [
	"Returns all changes corresponding to entities that did not change between the source and target model.."

	^ self select: [ :change | change isUnchanged ]
]

{ #category : #accessing }
FamixDiffResult >> moves [
	"Returns all changes corresponding to entities that moved between the source and target model."

	^ self select: [ :change | change isMove ]
]

{ #category : #accessing }
FamixDiffResult >> realChanges [
	"I return all the changes actually representing a change, rejecting identical changes."

	^ self reject: [ :change | change isUnchanged ]
]

{ #category : #accessing }
FamixDiffResult >> removals [
	"Returns all changes corresponding to the removal of an entity in the source model."

	^ self select: [ :change | change isRemoval ]
]

{ #category : #accessing }
FamixDiffResult >> renames [
	"Returns all changes corresponding to the renaming of an entity between the source and the target model."

	^ self select: [ :change | change isRename ]
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
