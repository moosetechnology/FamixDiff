Extension { #name : #FamixTNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> compareNameWith: otherEntity resolver: aResolver [

	<famixDiff: #identity priority: 3>
	<famixDiff: #move priority: 3>
	^ self name = otherEntity name
]

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> shouldBeConsideredForDiff [
	^ true
]
