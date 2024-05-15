"
I contain the results of the diff made on 2 models.

"
Class {
	#name : #FamixDiffResult,
	#superclass : #MooseGroup,
	#instVars : [
		'orchestrator'
	],
	#category : #'Famix-Diff-Core'
}

{ #category : #adding }
FamixDiffResult >> addChanges [
	^ self entityChanges allWithType: FamixAddChange
]

{ #category : #accessing }
FamixDiffResult >> allChanges [
	<navigation: 'All changes'>
	^ self entities
]

{ #category : #accessing }
FamixDiffResult >> allEntitiesImpactingChanges [
	^ self entityChanges reject: #isVersion
]

{ #category : #accessing }
FamixDiffResult >> allImpactingChanges [
	^ self entities reject: #isVersion
]

{ #category : #accessing }
FamixDiffResult >> assocChanges [
	<navigation: 'All assocChanges'>
	^ self select: [ :e | e isForAssociation ]
]

{ #category : #accessing }
FamixDiffResult >> assocRemovalChanges [
	^ self assocChanges allWithType: FamixRemovalChange
]

{ #category : #'as yet unclassified' }
FamixDiffResult >> bodyChanges [
	^ self select: #isBody
]

{ #category : #private }
FamixDiffResult >> changeTypeToDefaultType [
	self changeTypeTo: FamixDiffResult
]

{ #category : #accessing }
FamixDiffResult >> entityChanges [

	<navigation: 'All entity changes'>
	^ self
		  cacheAt: #entityChanges
		  ifAbsentPut: [ self reject: [ :e | e isForAssociation ] ]
]

{ #category : #accessing }
FamixDiffResult >> kindOfAssocAdditionChanges [
	^ self assocChanges select: #isKindOfAddition
]

{ #category : #accessing }
FamixDiffResult >> kindOfEntityAdditionChanges [
	^ self entityChanges select: #isKindOfAddition
]

{ #category : #accessing }
FamixDiffResult >> numberOfAdds [
	^ self entityChanges count: #isAddition
]

{ #category : #accessing }
FamixDiffResult >> numberOfDels [
	^ self entityChanges count: #isRemoval
]

{ #category : #accessing }
FamixDiffResult >> numberOfVersions [
	^ self entityChanges count: #isVersion
]

{ #category : #accessing }
FamixDiffResult >> orchestrator [
	^ orchestrator
]

{ #category : #accessing }
FamixDiffResult >> orchestrator: anObject [
	orchestrator := anObject
]

{ #category : #accessing }
FamixDiffResult >> removalChanges [
	^ self entityChanges allWithType: FamixRemovalChange
]

{ #category : #versions }
FamixDiffResult >> versionChanges [
	^ self entityChanges allWithType: FamixUnchangedChange 
]
