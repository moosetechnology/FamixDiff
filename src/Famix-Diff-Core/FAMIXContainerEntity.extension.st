Extension { #name : #FAMIXContainerEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXContainerEntity >> containedEntities [
	^ super containedEntities union: self types
]
