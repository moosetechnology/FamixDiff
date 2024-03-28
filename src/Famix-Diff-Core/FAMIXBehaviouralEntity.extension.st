Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> moveMatch: otherEntity resolver: resolver [

	(super moveMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: resolver tolerance
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> quasiEqualBody: otherEntity tolerance: percentage [

	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	| intersect myDependencies otherDependencies |
	myDependencies := self queryAllOutgoing.
	otherDependencies := otherEntity queryAllOutgoing.

	intersect := myDependencies select: [ :baseDependency | 
		             otherDependencies anySatisfy: [ :targetDependency | 
			             targetDependency class = baseDependency class and: [ 
				             baseDependency allTargets allSatisfy: [ :baseTarget | 
					             targetDependency allTargets anySatisfy: [ :targetTarget | baseTarget name = targetTarget name ] ] ] ] ].

	intersect size / myDependencies size >= (1 - percentage) ifFalse: [ ^ false ].
	intersect size / otherDependencies size >= (1 - percentage) ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> renameMatch: otherEntity resolver: resolver [

	(super renameMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: resolver tolerance
]
