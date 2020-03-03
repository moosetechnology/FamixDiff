accessing
indicatorsFor: aChange
	^ aChange changeMetrics, {FamixDiffIndicator new label:'Full Name'; computedValue: aChange entity mooseName}