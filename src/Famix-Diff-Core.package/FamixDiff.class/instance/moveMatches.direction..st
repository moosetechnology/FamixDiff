matching-entities
moveMatches: entities direction: fromOrToDirection
	| from to matchesBlock |
	fromOrToDirection = #to
		ifTrue: [ from := self moveCandidates: self baseModel.
			to := entities.
			matchesBlock := [ :eBase :eTarget | eTarget moveMatch: eBase givenChanges: self changesDico tolerance: self tolerance ] ]
		ifFalse: [ from := entities.
			to := self moveCandidates: self targetModel.
			matchesBlock := [ :eBase :eTarget | eBase moveMatch: eTarget givenChanges: self changesDico tolerance: self tolerance ] ].
	^ self
		matches: matchesBlock
		from: from
		to: to
		ifMatch: [ :eBase :eTarget | 
			| match |
			match := self makeChange: FamixMoveChange with: eBase with: eTarget.
			self changesDico at: eBase put: match; at: eTarget put: match ]
		progressMessage: 'Computing modifications' translated