Extension { #name : #FamixTNamedEntity }

{ #category : #'*Famix-Diff-Core' }
FamixTNamedEntity >> compareNameWith: otherEntity givenChanges: changes [

	<famixDiffIdentity>
	^ self name = otherEntity name
]
