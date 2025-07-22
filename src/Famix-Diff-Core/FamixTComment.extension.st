Extension { #name : 'FamixTComment' }

{ #category : '*Famix-Diff-Core' }
FamixTComment >> hasSameContentAs: otherEntity resolver: aResolver [

	<famixDiff: #identity priority: 3>
	^ self sourceTextHash = otherEntity sourceTextHash
]

{ #category : '*Famix-Diff-Core' }
FamixTComment >> moveMatch: otherEntity resolver: resolver [
	"Comments are never moved"

	^ false
]

{ #category : '*Famix-Diff-Core' }
FamixTComment >> renameMatch: otherEntity resolver: resolver [
	"Comments have no name"

	^ false
]

{ #category : '*Famix-Diff-Core' }
FamixTComment >> shouldBeConsideredForDiff [
	^ true
]

{ #category : '*Famix-Diff-Core' }
FamixTComment >> sourceTextHash [

	^ self cacheAt: #sourceTextHash ifAbsentPut: [ self sourceText hash ]
]
