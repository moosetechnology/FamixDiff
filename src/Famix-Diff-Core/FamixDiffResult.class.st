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

	self deprecated: 'Use #additions instead' transformWith: '`@rcv additionChanges' -> '`@rcv additions'.
	^ self additions
]

{ #category : #accessing }
FamixDiffResult >> additions [

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
FamixDiffResult >> groupAdditionsAndRemovalsByRoots [
	"When entities are not found in the base or target model we create additions and removals. This API method return a new set of changes that keeps only the top level additions and removals. If we add a package for example it will remove all its added classes methods and variables to keep a high level view of the changes."

	^ self select: [ :change |
		  change entity isAssociation not and: [
			  (change isAddition and: [ change entity parents noneSatisfy: [ :parent | self additions anySatisfy: [ :change2 | change2 entity = parent ] ] ]) or: [
				  change isRemoval and: [ change entity parents noneSatisfy: [ :parent | self removals anySatisfy: [ :change2 | change2 entity = parent ] ] ] ] ] ]
]

{ #category : #accessing }
FamixDiffResult >> moves [

	^ self select: [ :change | change isMove ]
]

{ #category : #accessing }
FamixDiffResult >> realChanges [
	"I return all the changes actually representing a change, rejecting identical changes."

	^ self reject: [ :change | change isUnchanged ]
]

{ #category : #accessing }
FamixDiffResult >> removalChanges [

	self deprecated: 'Use #removals instead' transformWith: '`@rcv removalChanges' -> '`@rcv removals'.
	^ self removals
]

{ #category : #accessing }
FamixDiffResult >> removals [

	^ self select: [ :change | change isRemoval ]
]

{ #category : #accessing }
FamixDiffResult >> renames [

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
