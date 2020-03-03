Extension { #name : #FamixChange }

{ #category : #'*Famix-Diff-Core' }
FamixChange >> comeBefore: aFamixChange [
	^ (self entity eq: aFamixChange entity)
		ifTrue:
			[ (self typeOrderPriority indexOf: self class)
				< (self typeOrderPriority indexOf: aFamixChange class) ]
		ifFalse: [ self entity comeBeforeEntity: aFamixChange entity ]
]

{ #category : #'*Famix-Diff-Core' }
FamixChange >> comeBeforeOrIsEquivalent: aFamixChange [
	^ (self comeBefore: aFamixChange)
		or: [ self class = aFamixChange class and: [ self entity comeBeforeEntityOrHasSameName: aFamixChange entity ] ]
]

{ #category : #'*Famix-Diff-Core' }
FamixChange >> edgesToRelatedItems [
	"
	Orion Note from Vincent Blondeau
	This method can't be distributed on the entities to use the object programming standards. Because if it the case, you have to use a FMMultivalue link to go from the entity to the change and as the entity is changing of state (Moose -> Orion). It is not possible to persist the link in the new version.
	"

	| parents |
	parents := self entityToGetParent parents reject: #isNil.
	self entityToGetParent isType
		ifTrue:
			[ parents := parents union: self entityToGetParent directSuperclasses ].
	(self entityToGetParent isKindOf: FAMIXParameterizedType)
		ifTrue: [ self entityToGetParent parameterizableClass
				ifNotNil: [ :paramClass | 
					parents := parents asOrderedCollection
						add: paramClass;
						yourself ] ].
	^ parents
		collect:
			[ :parentItem | "The version after is more accurate but take more time and create cycles... We try to make the diff sort without..." "parents := self entityToGetParent parentEntities reject: #isNil.
	self entityToGetParent isType
		ifTrue: [ parents := parents union: self entityToGetParent directSuperclasses ].
	(self entityToGetParent isKindOf: FAMIXParameterizedType)
		ifTrue: [ self entityToGetParent parameterizableClass
				ifNotNil: [ :paramClass | 
					parents := parents asOrderedCollection
						add: paramClass;
						yourself ].
			parents := parents asOrderedCollection
				addAll: self entityToGetParent arguments;
				yourself ].
	^ parents collect: [ :parentItem | parentItem -> self entityToGetParent ]" parentItem -> self entityToGetParent ]
]

{ #category : #'*Famix-Diff-Core' }
FamixChange >> entityToGetParent [
	^ self entity
]

{ #category : #'*Famix-Diff-Core' }
FamixChange >> typeOrderPriority [ 
	 ^{ FamixVersionChange . FamixRenameChange . FamixAddChange . FamixMoveChange ". FamixRemovalChange" }
]

{ #category : #'*Famix-Diff-Core' }
FamixChange >> updateDiffForAssociations: aFamixDiff [
	^ self subclassResponsibility
]
