Extension { #name : #FamixPairedChange }

{ #category : #'*Famix-Diff-Core' }
FamixPairedChange >> updateDiffForAssociations: aFamixDiff [

	aFamixDiff checkAssocsMatches: self baseEntity queryAllLocalOutgoing with: self targetEntity queryAllLocalOutgoing
]
