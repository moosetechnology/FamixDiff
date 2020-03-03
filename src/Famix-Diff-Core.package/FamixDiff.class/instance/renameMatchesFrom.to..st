matching-entities
renameMatchesFrom: baseEntities to: targetEntities
	"Find the entities that have been renamed between base version and target version (using #renameMatch:givenChanges:tolerance: message).
	 If there is a match, a FamixRenameChange is created and stored."

	^ self
		matches: [ :eBase :eTarget | eBase renameMatch: eTarget givenChanges: self changesDico tolerance: self tolerance ]
		from: baseEntities
		to: targetEntities
		ifMatch: [ :eBase :eTarget | 
			| match |
			match := self makeChange: FamixRenameChange with: eBase with: eTarget.
			self changesDico
				at: eBase put: match;
				at: eTarget put: match ]
		progressMessage: 'Computing renamed entities' translated