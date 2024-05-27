"
Abstract class for possible changes.
Basically introduces the testing methods: isRemoval, isModification, isChange, isAddition
"
Class {
	#name : #FamixChange,
	#superclass : #Object,
	#instVars : [
		'entity'
	],
	#category : #'Famix-Diff-ChangeModel'
}

{ #category : #accessing }
FamixChange class >> base: baseEntity target: targetEntity [

	^ (self entity: baseEntity)
		  targetEntity: targetEntity;
		  yourself
]

{ #category : #accessing }
FamixChange class >> changeName [
	^ self subclassResponsibility
]

{ #category : #accessing }
FamixChange class >> entity: anEntity [

	^ self new
		  entity: anEntity;
		  yourself
]

{ #category : #comparing }
FamixChange >> = anObject [
	^ (anObject class = self class) and: [ 
			anObject entity = self entity ]
]

{ #category : #visiting }
FamixChange >> accept: aVisitor [
	aVisitor visitChange: self
]

{ #category : #accessing }
FamixChange >> baseEntity [
	^ self entity
]

{ #category : #accessing }
FamixChange >> baseEntity: anObject [
	self entity: anObject
]

{ #category : #accessing }
FamixChange >> changeName [
	^ self class changeName
]

{ #category : #accessing }
FamixChange >> entity [
	
	^ entity
]

{ #category : #accessing }
FamixChange >> entity: anEntity [
	entity := anEntity
]

{ #category : #accessing }
FamixChange >> entityName [
	
	^ entity name
]

{ #category : #comparing }
FamixChange >> hash [
	^ self entity hash bitXor: self entityName hash
]

{ #category : #testing }
FamixChange >> isAddition [

	^false
]

{ #category : #testing }
FamixChange >> isBody [
	^ false
]

{ #category : #testing }
FamixChange >> isForAssociation [
	^ entity isAssociation
]

{ #category : #testing }
FamixChange >> isKindOfAddition [
	^ self isAddition
		or: [ self isMove or: [ self isRename or: [ self isBody ] ] ]
]

{ #category : #testing }
FamixChange >> isMatch [
	^ false
]

{ #category : #testing }
FamixChange >> isMove [
	^ false
]

{ #category : #testing }
FamixChange >> isRemoval [

	^false
]

{ #category : #testing }
FamixChange >> isRename [
	^ false
]

{ #category : #testing }
FamixChange >> isUnchanged [

	^false
]

{ #category : #printing }
FamixChange >> printOn: stream [
	stream
		<< self changeName;
		<< '(';
		<< entity class name;
		<< ') ';
		<< entity mooseName
]

{ #category : #accessing }
FamixChange >> targetEntity [
	^ self entity
]
