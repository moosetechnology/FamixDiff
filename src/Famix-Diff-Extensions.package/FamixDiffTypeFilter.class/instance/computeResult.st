result
computeResult
	^ self changes select: [ :aChange | self selection includes: aChange entity class  ].
