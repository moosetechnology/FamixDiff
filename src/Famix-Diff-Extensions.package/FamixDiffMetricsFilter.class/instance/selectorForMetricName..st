pre-format
selectorForMetricName: aString
	| indFound |
	indFound := self changes
		collect: [ :aChange | 
			aChange entityChangeIndicators
				do: [ :ind | 
					(ind label compare: aString) = 2
						ifTrue: [ ^ ind selector ] ] ].