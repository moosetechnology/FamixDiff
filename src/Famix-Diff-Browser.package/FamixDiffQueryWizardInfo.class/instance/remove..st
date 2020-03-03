accessing
remove: aSymbol
	(typesSelected includes: aSymbol) ifTrue: [typesSelected remove: aSymbol]