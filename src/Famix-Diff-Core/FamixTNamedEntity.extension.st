Extension { #name : #FamixTNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> compareNameWith: otherEntity [

	<famixDiffIdentity>
	^ self name = otherEntity name
]
