Extension { #name : #FAMIXContainerEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> equalContent: otherEntity tolerance: percentage [

	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	| intersect |
	intersect := self children select: [ :myE | otherEntity children anySatisfy: [ :otherE | myE name = otherE name ] ].
	(self children isNotEmpty and: [ intersect size / self children size >= (1 - percentage) ]) ifFalse: [ ^ false ].
	(otherEntity children isNotEmpty and: [ intersect size / otherEntity children size >= (1 - percentage) ]) ifFalse: [ ^ false ].
	^ true
]
