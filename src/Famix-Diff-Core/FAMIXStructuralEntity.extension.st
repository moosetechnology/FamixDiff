Extension { #name : #FAMIXStructuralEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXStructuralEntity >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super moveMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self quasiEqualAccesses: otherEntity tolerance: percentage
]

{ #category : #'*Famix-Diff-Core' }
FAMIXStructuralEntity >> quasiEqualAccesses: otherEntity tolerance: percentage [
	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"
	| intersect |

	"to make a meaningfull decision we require enough information"
	(self incomingAccesses size >= 3) ifFalse:  [ ^ false ].
	(otherEntity incomingAccesses size >= 3) ifFalse:  [ ^ false ].

	intersect := self incomingAccesses select: [ :myAcc | otherEntity incomingAccesses anySatisfy: [:otherAcc | myAcc accessor name = otherAcc accessor name ] ].

	( (intersect size / self incomingAccesses size) >= (1-percentage) )
		ifFalse: [  ^ false ].
	( (intersect size / otherEntity incomingAccesses size) >= (1-percentage) )
		ifFalse: [  ^ false ].

	^ true
]
