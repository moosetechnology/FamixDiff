Extension { #name : #FAMIXEnum }

{ #category : #'*Famix-Diff-Core' }
FAMIXEnum >> containedEntities [
	^ super containedEntities union: self values
]
