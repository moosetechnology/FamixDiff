mapping
changeClassesFrom: aCollectionOfDisplayNames
	^ aCollectionOfDisplayNames collect: [:aChangName | FamixChange allSubclasses detect: [:aClass | aChangName = aClass displayName] ifNone: [ nil ]]