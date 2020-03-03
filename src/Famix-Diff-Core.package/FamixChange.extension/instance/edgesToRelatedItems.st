*Famix-Diff-Core
edgesToRelatedItems
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