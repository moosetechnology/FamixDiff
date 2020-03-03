sorting
compareChange: aChange with: anotherChange
	| indicatorOne indicatorTwo |
	indicatorOne := aChange changeMetrics detect: [:indic | indic selector = self sortSelector] ifNone: [^false].
	indicatorTwo := anotherChange changeMetrics detect: [:indic | indic selector = self sortSelector] ifNone: [^false].
	^ indicatorOne computedValue abs perform: self sortComparator with: indicatorTwo computedValue abs