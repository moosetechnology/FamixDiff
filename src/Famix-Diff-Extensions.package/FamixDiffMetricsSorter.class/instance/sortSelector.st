as yet unclassified
sortSelector
	^ sortSelector ifNil: [sortSelector := self selectorForMetricName: self selection first]