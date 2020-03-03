accessing
pckgFilter: filter
	filter ifNil: [ pckgFilter := '' ] ifNotNil: [pckgFilter := filter]