result
computeResult
	| selectors |
	selectors := self selection collect: #filterSelector.
	^self changes select: [ :aChange | selectors anySatisfy: [ :aSel | aChange perform: aSel ] ].