Extension { #name : #FAMIXContainerEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> equalContent: otherEntity resolver: resolver [

	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	| intersect |
	intersect := self children select: [ :baseChild | otherEntity children anySatisfy: [ :targetChild | baseChild name = targetChild name ] ].
	(self children isNotEmpty and: [ intersect size / self children size >= (1 - resolver tolerance) ]) ifFalse: [ ^ false ].
	(otherEntity children isNotEmpty and: [ intersect size / otherEntity children size >= (1 - resolver tolerance) ]) ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> renameMatch: otherEntity resolver: resolver [

	(super renameMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self equalContent: otherEntity resolver: resolver
]
