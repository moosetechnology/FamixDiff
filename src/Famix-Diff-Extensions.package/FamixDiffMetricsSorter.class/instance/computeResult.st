result
computeResult
	^  (self changes select: [ :c | c entity respondsTo: self sortSelector ]) asSet sorted: [:aChange :anotherChange | self compareChange: aChange with: anotherChange].