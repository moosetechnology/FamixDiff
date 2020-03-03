result
shouldIcludeInResults: aChange
	aChange changeMetrics
		do: [ :indicator | 
			self userThresholds
				do: [ :aTh | 
					aTh selector = indicator selector
						ifTrue: [ 
							(aTh numberRespects: indicator computedValue)
								ifFalse: [ ^ false ] ] ] ].
	^ true