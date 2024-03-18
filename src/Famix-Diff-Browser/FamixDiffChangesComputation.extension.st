Extension { #name : #FamixDiffChangesComputation }

{ #category : #'*Famix-Diff-Browser' }
FamixDiffChangesComputation >> indicatorsFor: aChange [
	^ aChange changeMetrics, {FamixDiffIndicator new label:'Full Name'; computedValue: aChange entity mooseName}
]
