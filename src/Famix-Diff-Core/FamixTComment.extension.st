Extension { #name : #FamixTComment }

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> isIdenticalTo: otherEntity resolver: resolver [

	(self hasSameClassAs: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	self sourceTextHash = otherEntity sourceTextHash ifFalse: [ ^ false ].
	(self compareParentsWith: otherEntity resolver: resolver) ifFalse: [ ^ false ].

	^ true
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> moveMatch: otherEntity resolver: resolver [
	"Comments are never moved"

	^false
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> renameMatch: otherEntity resolver: resolver [
	"Comments have no name"

	^ false
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> shouldBeConsideredForDiff [
	^ true
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> sourceTextHash [

	^ self cacheAt: #sourceTextHash ifAbsentPut: [ self sourceText hash ]
]
