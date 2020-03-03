result
computeResult
	^ self changes select: [:aChange | 
		self shouldIcludeInResults: aChange].
	