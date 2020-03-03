as yet unclassified
testAllSubClasses
	FamixChange allSubclasses do: [:aClass | self deny: (filterParams changeClassesFrom: {aClass displayName}) isNil]