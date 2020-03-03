private
metricsFilter
	^ metricsFilter ifNil: [ metricsFilter := FamixDiffMetricsFilter new changes: self changes; yourself ]