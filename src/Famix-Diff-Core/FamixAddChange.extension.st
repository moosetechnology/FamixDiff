Extension { #name : #FamixAddChange }

{ #category : #'*Famix-Diff-Core' }
FamixAddChange >> updateDiffForAssociations: aFamixDiff [
	aFamixDiff addAssociations: self entity queryAllLocalOutgoing
]
