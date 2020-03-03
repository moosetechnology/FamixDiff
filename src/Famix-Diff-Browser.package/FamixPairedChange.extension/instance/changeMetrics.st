*Famix-Diff-Browser
changeMetrics
	^ self entityChangeIndicators collect: [:anIndicator |
			anIndicator computedValue: ((self targetEntity perform: anIndicator selector) - (self targetEntity perform: anIndicator selector)).
			anIndicator
			]