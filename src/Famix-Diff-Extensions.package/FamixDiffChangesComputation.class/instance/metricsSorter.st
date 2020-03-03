private
metricsSorter
	^ metricsSorter ifNil: [ metricsSorter := FamixDiffMetricsSorter new changes: self changes; yourself ]