Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> equalContentAndDependencies: otherEntity resolver: resolver [

	"In order to know if an entity was moved or renamed we compare its children and its dependencies. If they are the same we can consider an entity is the same.
	
	Tolerance is used to give some flexibility because an entity can be renamed and slightly modified.
	tolerance 0 => both entities must be strictly equals
	tolerance=1 (100%) => entities can be completly different"

	| baseChildren targetChildren intersect baseOutgoingDependencies targetOutgoingDependencies baseIncomingDependencies targetIncomingDependencies |
	baseChildren := self children.
	targetChildren := otherEntity children.

	baseOutgoingDependencies := self queryAllOutgoing.
	targetOutgoingDependencies := otherEntity queryAllOutgoing.

	baseIncomingDependencies := self queryAllIncoming.
	targetIncomingDependencies := otherEntity queryAllIncoming.

	"If we have nothing in the class we consider they are different."
	(baseChildren isEmpty and: [ baseOutgoingDependencies isEmpty and: [ baseIncomingDependencies isEmpty ] ]) ifTrue: [ ^ false ].
	(targetChildren isEmpty and: [ targetOutgoingDependencies isEmpty and: [ targetIncomingDependencies isEmpty ] ]) ifTrue: [ ^ false ].

	intersect := OrderedCollection new.

	"Since we did not treat the children with the resolver  yet we do not check via the resolver if they are the same entities because even if they are renamed we will not know it yet."
	intersect addAll: (baseChildren select: [ :baseChild | targetChildren anySatisfy: [ :targetChild | baseChild name = targetChild name ] ]).

	intersect addAll: (baseOutgoingDependencies select: [ :baseDependency | 
			 targetOutgoingDependencies anySatisfy: [ :targetDependency | 
				 targetDependency class = baseDependency class and: [ 
					 baseDependency allTargets allSatisfy: [ :baseTarget | targetDependency allTargets anySatisfy: [ :targetTarget | baseTarget name = targetTarget name ] ] ] ] ]).

	intersect addAll: (baseIncomingDependencies select: [ :baseDependency | 
			 targetIncomingDependencies anySatisfy: [ :targetDependency | 
				 targetDependency class = baseDependency class and: [ baseDependency source name = targetDependency source name ] ] ]).

	intersect size / (baseChildren size + baseOutgoingDependencies size + baseIncomingDependencies size) >= (1 - resolver tolerance) ifFalse: [ ^ false ].
	intersect size / (targetChildren size + targetOutgoingDependencies size + targetIncomingDependencies size) >= (1 - resolver tolerance) ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> moveMatch: otherEntity resolver: resolver [

	"stubs either are identical or nothing, no renaming or moving allowed"

	self isStub ifTrue: [ ^ false ].
	otherEntity isStub ifTrue: [ ^ false ].

	self class = otherEntity class ifFalse: [ ^ false ].
	(self compareNameWith: otherEntity) ifFalse: [ ^ false ].

	^ (self compareParentsWith: otherEntity resolver: resolver) not
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> shouldBeConsideredForDiff [
	^ true
]
