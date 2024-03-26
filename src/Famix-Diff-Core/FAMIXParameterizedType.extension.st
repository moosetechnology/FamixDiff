Extension { #name : #FAMIXParameterizedType }

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> equalArguments: otherEntity tolerance: percentage [
	^ self arguments equalNameOwner: otherEntity arguments
]

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super moveMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self equalArguments: otherEntity tolerance: percentage
]

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> renameMatch: otherEntity resolver: resolver [

	(super renameMatch: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	^ self equalArguments: otherEntity tolerance: resolver tolerance
]
