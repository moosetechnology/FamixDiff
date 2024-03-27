Extension { #name : #FAMIXParameterizedType }

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> equalArguments: otherEntity tolerance: percentage [
	^ self arguments equalNameOwner: otherEntity arguments
]

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> moveMatch: otherEntity resolver: resolver [

	(super moveMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self equalArguments: otherEntity tolerance: resolver tolerance
]

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> renameMatch: otherEntity resolver: resolver [

	(super renameMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self equalArguments: otherEntity tolerance: resolver tolerance
]
