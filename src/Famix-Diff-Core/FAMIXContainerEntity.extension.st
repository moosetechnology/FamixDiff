Extension { #name : #FAMIXContainerEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> equalContentAndDependencies: otherEntity resolver: resolver [

	"In order to know if an entity was moved or renamed we compare its children and its dependencies. If they are the same we can consider an entity is the same.
	
	Tolerance is used to give some flexibility because an entity can be renamed and slightly modified.
	tolerance 0 => both entities must be strictly equals
	tolerance=1 (100%) => entities can be completly different"

	| myChildren targetChildren intersect myDependencies targetDependencies |
	myChildren := self children.
	targetChildren := otherEntity children.

	myDependencies := self queryAllOutgoing.
	targetDependencies := otherEntity queryAllOutgoing.

	"If we have nothing in the class we consider they are different."
	(myChildren isEmpty and: [ myDependencies isEmpty ]) ifTrue: [ ^ false ].
	(targetChildren isEmpty and: [ targetDependencies isEmpty ]) ifTrue: [ ^ false ].

	intersect := OrderedCollection new.

	"Since we did not treat the children with the resolver  yet we do not check via the resolver if they are the same entities because even if they are renamed we will not know it yet."
	intersect addAll: (myChildren select: [ :baseChild | targetChildren anySatisfy: [ :targetChild | baseChild name = targetChild name ] ]).

	intersect addAll: (myDependencies select: [ :baseDependency | 
			 targetDependencies anySatisfy: [ :targetDependency | 
				 targetDependency class = baseDependency class and: [ 
					 baseDependency allTargets allSatisfy: [ :baseTarget | targetDependency allTargets anySatisfy: [ :targetTarget | baseTarget name = targetTarget name ] ] ] ] ]).

	intersect size / myChildren size >= (1 - resolver tolerance) ifFalse: [ ^ false ].
	intersect size / targetChildren size >= (1 - resolver tolerance) ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> moveMatch: otherEntity resolver: resolver [

	(super moveMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self equalContentAndDependencies: otherEntity resolver: resolver
]

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> renameMatch: otherEntity resolver: resolver [

	(super renameMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self equalContentAndDependencies: otherEntity resolver: resolver
]
