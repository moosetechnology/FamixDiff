Extension { #name : #FAMIXEntity }

{ #category : #'*Famix-Diff-Browser' }
FAMIXEntity class >> displayName [
	^self name copyFrom: self prefixLength + 1 to: self name size
]
