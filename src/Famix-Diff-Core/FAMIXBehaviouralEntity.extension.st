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

	| intersect mySize otherSize |
	"to make a meaningfull decision we require enough information"
	mySize := ((self accesses union: self outgoingInvocations) union: self outgoingReferences) size.

	otherSize := ((otherEntity accesses union: otherEntity outgoingInvocations) union: otherEntity outgoingReferences) size.

	"compare invoked methods "
	intersect := self outgoingInvocations select: [ :myInv | 
		             otherEntity outgoingInvocations anySatisfy: [ :otherInv | myInv receiver mooseName = otherInv receiver mooseName ] ].

	"compare refered classes "
	intersect addAll:
		(self outgoingReferences select: [ :myRef | otherEntity outgoingReferences anySatisfy: [ :otherRef | myRef target name = otherRef target name ] ]).


	"compare (outgoing) accesses"
	intersect addAll: (self accesses select: [ :myAcc | otherEntity accesses anySatisfy: [ :otherAcc | myAcc variable name = otherAcc variable name ] ]).
	intersect size / mySize >= (1 - percentage) ifFalse: [ ^ false ].
	intersect size / otherSize >= (1 - percentage) ifFalse: [ ^ false ].
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FAMIXBehaviouralEntity >> renameMatch: otherEntity resolver: resolver [

	(super renameMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self quasiEqualBody: otherEntity tolerance: resolver tolerance
]
