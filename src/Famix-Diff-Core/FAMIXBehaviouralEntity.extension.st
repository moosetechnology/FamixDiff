Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> containedEntities [
	^ (super containedEntities union: self localVariables)  union: self parameters
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> identityMatch: otherEntity givenChanges: changes [
	^ (super identityMatch: otherEntity givenChanges: changes)
		and: [ self signature = otherEntity signature ]
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super moveMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: percentage
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> quasiEqualBody: otherEntity tolerance: percentage [
	"tolerance is used to give some flexibility
     we require that any entity has at most percentage members not in the other entity
     tolerance 0 => both entities must be strictly equals
     tolerance=1 (100%) => entities can be completly different"

	| intersect mySize otherSize |
	"to make a meaningfull decision we require enough information"
	mySize := ((((self localVariables union: self parameters) union: self accesses) union: self outgoingInvocations) union: self outgoingReferences) size.
	mySize >= 3
		ifFalse: [ ^ false ].
	otherSize := ((((otherEntity localVariables union: otherEntity parameters) union: otherEntity accesses) union: otherEntity outgoingInvocations)
		union: otherEntity outgoingReferences) size.
	otherSize >= 3
		ifFalse: [ ^ false ].

	"compare invoked methods "
	intersect := self outgoingInvocations select: [ :myInv | otherEntity outgoingInvocations anySatisfy: [ :otherInv | myInv receiver mooseName = otherInv receiver mooseName ] ].

	"compare refered classes "
	intersect addAll: (self outgoingReferences select: [ :myRef | otherEntity outgoingReferences anySatisfy: [ :otherRef | myRef to name = otherRef to name ] ]).

	"compare local variables"
	intersect addAll: (self localVariables select: [ :myVar | otherEntity localVariables anySatisfy: [ :otherVar | myVar name = otherVar name ] ]).

	"compare local parameters"
	intersect addAll: (self parameters select: [ :myVar | otherEntity parameters anySatisfy: [ :otherVar | myVar name = otherVar name ] ]).

	"compare (outgoing) accesses"
	intersect addAll: (self accesses select: [ :myAcc | otherEntity accesses anySatisfy: [ :otherAcc | myAcc variable name = otherAcc variable name ] ]).
	intersect size / mySize >= (1 - percentage)
		ifFalse: [ ^ false ].
	intersect size / otherSize >= (1 - percentage)
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> renameMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super renameMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: percentage
]
