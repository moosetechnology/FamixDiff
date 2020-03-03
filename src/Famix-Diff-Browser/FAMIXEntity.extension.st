Extension { #name : #FAMIXEntity }

{ #category : #'*Famix-Diff-Browser' }
FAMIXEntity class >> characterName [
	^$X
]

{ #category : #'*Famix-Diff-Browser' }
FAMIXEntity class >> displayName [
	^(self name copyAfter: self characterName)
]
