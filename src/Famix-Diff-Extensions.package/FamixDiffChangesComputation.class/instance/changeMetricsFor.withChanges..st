change-metrics
changeMetricsFor: aTypeCollection withChanges: aChangesCollection
	| metricsDict |
	metricsDict := Dictionary new.
	(aChangesCollection
		select: [ :aChange | aTypeCollection includes: aChange entity class displayName ])
		do: [ :aChange | 
			metricsDict
				at: aChange entity class displayName asSymbol
				ifAbsentPut: [ aChange entityChangeIndicators ] ].
	^ metricsDict