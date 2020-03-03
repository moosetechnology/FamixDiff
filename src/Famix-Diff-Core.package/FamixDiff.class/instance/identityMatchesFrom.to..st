matching-entities
identityMatchesFrom: baseEntities to: targetEntities
	"Find the entities that are exactly the same between base version and target version (using #identityMatch:givenChanges: message).
	 If there is a match, a FamixVersionChange is created and stored."

	^ self
		matches: [ :eBase :eTarget | eBase identityMatch: eTarget givenChanges: self changesDico ]
		from: baseEntities
		to: targetEntities
		ifMatch: [ :eBase :eTarget | 
			| match |
			targetEntities remove: eTarget.
			match := self makeChange: FamixVersionChange with: eBase with: eTarget.
			self changesDico
				at: eBase put: match;
				at: eTarget put: match ]
		progressMessage: 'Comparing two versions' translated