Extension { #name : 'FamixRemovalChange' }

{ #category : '*Famix-Diff-Core' }
FamixRemovalChange >> updateDiffForAssociations: aFamixDiff [
	aFamixDiff delAssociations: self entity queryAllLocalOutgoing
]
