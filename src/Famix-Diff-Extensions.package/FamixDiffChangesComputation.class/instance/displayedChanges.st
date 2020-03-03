accessing
displayedChanges
	^ displayedChanges ifNil: [self changes]