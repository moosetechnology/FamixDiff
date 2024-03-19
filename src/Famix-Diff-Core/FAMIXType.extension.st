Extension { #name : #FAMIXType }

{ #category : #'*Famix-Diff-Core' }
FAMIXType >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super moveMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: percentage
]

{ #category : #'*Famix-Diff-Core' }
FAMIXType >> quasiEqualBody: otherEntity tolerance: percentage [ 
	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"
	| intersect myMeths otherMeths |

	"to make a meaningfull decision we require enough information"
	((self methods union: self attributes) size >= 3) ifFalse:  [ ^ false ].
	((otherEntity methods union: otherEntity attributes) size >= 3) ifFalse:  [ ^ false ].

	myMeths := self methods.
	otherMeths := otherEntity methods.
	self sourceLanguage isJava ifTrue: [
		"in Java ignore constructor"
		myMeths := myMeths reject: [:m | m name = self name].
		otherMeths  := otherMeths reject: [:m | m name = otherEntity name]
	].

	intersect := myMeths select: [ :myMth | otherMeths anySatisfy: [:otherMth | myMth name = otherMth name ] ].
	intersect addAll: (self attributes select: [ :myVar | otherEntity attributes anySatisfy: [:otherVar | myVar name =otherVar name ] ]).
	
	( intersect size / (self attributes size + myMeths size) >= (1-percentage) )
		ifFalse: [  ^ false ].
	( intersect size / (otherEntity attributes size + otherMeths size) >= (1-percentage) )
		ifFalse: [  ^ false ].

	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXType >> renameMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super renameMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: percentage
]
