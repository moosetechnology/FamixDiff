Extension { #name : #FamixTAssociation }

{ #category : #'*Famix-Diff-Core' }
FamixTAssociation >> matches: otherAssoc resolver: resolver [

	self class = otherAssoc class ifFalse: [ ^ false ].

	(self myEntity: self source matches: otherAssoc source resolver: resolver) ifFalse: [ ^ false ].
	^ self allTargets anySatisfy: [ :selfCandidate | 
		  otherAssoc allTargets anySatisfy: [ :otherCandidate | self myEntity: selfCandidate matches: otherCandidate resolver: resolver ] ]
]

{ #category : #'*Famix-Diff-Core' }
FamixTAssociation >> myEntity: myEntity matches: otherEntity resolver: resolver [

	"two entities in an association matche if:
		both are stubs and their full names match
		or neither is stub and they are known to match (in entitentityChanges)"

	myEntity ifNil: [ ^ otherEntity isNil ].
	otherEntity ifNil: [ ^ false ].

	(myEntity isStub and: [ otherEntity isStub ]) ifTrue: [ ^ myEntity displayString = otherEntity displayString ].
	"	otherEntity isStub ifTrue: [^ false]." "There should not be a stub check..."
	^ (resolver changes at: myEntity) = (resolver changes at: otherEntity)
]
