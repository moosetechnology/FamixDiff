*Famix-Diff-Browser
changeMetrics
	^ self entityChangeIndicators collect: [:anIndicator |
			(anIndicator computedValue: ((self entity perform: anIndicator selector) perform: self signSelector)).
			anIndicator
			]