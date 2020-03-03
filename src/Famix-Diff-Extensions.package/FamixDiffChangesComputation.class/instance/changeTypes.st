changes-search
changeTypes
	^ self changes collectAsSet: [:aChange | aChange class displayName].