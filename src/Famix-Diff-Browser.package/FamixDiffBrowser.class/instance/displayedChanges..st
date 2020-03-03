accessing
displayedChanges: anObject
	changesComputation displayedChanges: anObject.
	((browser paneNamed: #changesList) port: #entity) value: anObject.
	(browser paneNamed: #changesList) update