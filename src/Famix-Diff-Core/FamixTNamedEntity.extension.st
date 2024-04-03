Extension { #name : #FamixTNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> compareNameWith: otherEntity [

	<famixDiff: #identity priority: 8>
	<famixDiff: #move priority: 8>
	^ self name = otherEntity name
]

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> shouldBeConsideredForDiff [
	^ true
]
