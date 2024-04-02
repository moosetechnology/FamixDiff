Extension { #name : #FAMIXContainerEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> moveMatch: otherEntity resolver: resolver [

	(super moveMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self hasEqualContentAndDependencies: otherEntity resolver: resolver
]
