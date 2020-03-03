accessing
assocChanges
	<navigation: 'All assocChanges'>
	^ self select: [ :e | e isForAssociation ]