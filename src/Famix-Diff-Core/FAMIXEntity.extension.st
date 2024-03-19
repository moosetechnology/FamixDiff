Extension { #name : #FAMIXEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity class >> prefixLength [
	^'FAMIX' size
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> shouldBeConsideredForDiff [
	^ false
]
