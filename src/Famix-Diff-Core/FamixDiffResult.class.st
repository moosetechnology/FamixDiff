"
I contain the results of the diff made on 2 models.

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
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

{ #category : #'as yet unclassified' }
FamixDiffResult >> mooseFinderNotSortedListIn: composite [
	<moosePresentationOrder: 0>
	composite list
		beMultiple;
		showOnly: 50;
		searchOn:
				[ :text :each | 
			Smalltalk compiler
				evaluate: ' | entity each | each := self. entity := each.' , text
				for: each
				logged: false ];
		display: #mooseInterestingEntity;
		
		send:
				[ :each | 
			each isNil
				ifTrue: [ nil ]
				ifFalse: [ each size = 1
						ifTrue: [ each first ]
						ifFalse: [ each asMooseGroup ] ] ];
		format: #mooseDisplayString;
		icon: #mooseIcon;
		title: [ :each | each mooseInterestingEntity size asString , ' items' ];
		titleIcon: MooseIcons mooseList;
		when:
				[ :input | 
			(input mooseInterestingEntity isKindOf: MooseGroup)
				or: [ input mooseInterestingEntity isKindOf: Collection ] ];
		dynamicActionsOnSelection: [ :list | list selection mooseInterestingEntity mooseFinderActions ];
		updateOn: MooseEntityAdded from: [ :anObject | MooseFinder announcerFor: anObject ];
		updateOn: MooseEntityRemoved from: [ :anObject | MooseFinder announcerFor: anObject ];
		helpMessage:
			'A selection boolean statement using ''each'' to refer to each element' , String cr
				, 'For example: ' , String cr , 'each beginsWith:''C'''
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
	^ self entityChanges allWithType: FamixVersionChange 
]
