Extension { #name : #FamixTComment }

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> isIdenticalTo: otherEntity resolver: resolver [

	(self hasSameClassAs: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	(self compareParentsWith: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	(self content = otherEntity content) ifFalse: [ ^ false ].
	 ^ true
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> moveMatch: otherEntity resolver: resolver [
	"Comments are never moved"

	^false
]
