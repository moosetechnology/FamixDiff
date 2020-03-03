mapping
typeClassesFrom: aCollectionOfDisplayNames
	^ aCollectionOfDisplayNames
		collect: [ :aDisplayName | FAMIXEntity allSubclasses detect: [ :aClass | aDisplayName = aClass displayName ] ifNone: [ nil ] ]