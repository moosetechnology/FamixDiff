Extension { #name : #FAMIXParameterizedType }

{ #category : #'*Famix-Diff-Core' }
FAMIXParameterizedType >> containedEntities [
	^ super containedEntities union: self arguments
]

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
FAMIXParameterizedType >> renameMatch: otherEntity givenChanges: changes tolerance: percentage [
	(super renameMatch: otherEntity givenChanges: changes tolerance: percentage)
		ifFalse: [ ^ false ].
	^ self equalArguments: otherEntity tolerance: percentage
]
