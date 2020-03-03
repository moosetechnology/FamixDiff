accessing
add: aSymbol
	(typesSelected includes: aSymbol) ifFalse: [typesSelected add: aSymbol]