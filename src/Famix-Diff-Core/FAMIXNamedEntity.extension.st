Extension { #name : #FAMIXNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> moveMatch: otherEntity resolver: resolver [

	(self isNotStubWith: otherEntity) ifFalse: [ ^ false ].

	(self hasSameClassAs: otherEntity) ifFalse: [ ^ false ].
	(self compareNameWith: otherEntity) ifFalse: [ ^ false ].

	(self compareParentsWith: otherEntity resolver: resolver) ifTrue: [ ^ false ].
	^ self hasEqualContentAndDependencies: otherEntity resolver: resolver
]

{ #category : #'*Famix-Diff-Core' }
FAMIXNamedEntity >> shouldBeConsideredForDiff [
	^ true
]
