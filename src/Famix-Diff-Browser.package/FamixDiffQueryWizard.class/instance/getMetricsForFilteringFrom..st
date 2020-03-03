metrics
getMetricsForFilteringFrom: aDictionaryOfSelections
	| metricsSelectors |
	metricsSelectors := (aDictionaryOfSelections associationsSelect: [ :each | (each key includesSubstring: 'metric') and: [ each value ] ]) 	keys collect: [ :assoc | (assoc asString copyAfter: $c) ].
		^ (metricsSelectors collect: [:aSelector |
		(aSelector asSymbol) ->
			{(aDictionaryOfSelections associationsSelect: [ :each | (each key copyAfter: $n) = aSelector]) values first value asInteger . (aDictionaryOfSelections associationsSelect: [ :each | (each key copyAfter: $x) = aSelector]) values first value asInteger}  ]) asDictionary