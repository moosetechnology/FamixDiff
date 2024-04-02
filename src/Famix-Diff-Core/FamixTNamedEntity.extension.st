Extension { #name : #FamixTNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> compareNameWith: otherEntity [

	<famixDiff: #identity priority: 50>
	^ self name = otherEntity name
]
