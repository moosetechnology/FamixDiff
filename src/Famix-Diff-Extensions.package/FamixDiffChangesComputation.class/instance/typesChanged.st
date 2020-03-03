changes-search
typesChanged
	^ self changes collectAsSet: [ :each | each entity class displayName ].