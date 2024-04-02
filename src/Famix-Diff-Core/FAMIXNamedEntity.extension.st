Extension { #name : #FAMIXNamedEntity }

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
