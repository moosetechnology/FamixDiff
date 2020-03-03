run-entities
inFilteredPackage: e
	e ifNil: [ ^ false ].
	e isScopingEntity
		ifFalse: [ e parentPackage
				ifNil: [ ^ self inFilteredPackage: e belongsTo ]
				ifNotNil: [ ^ self inFilteredPackage: e parentPackage ] ].
	pckgFilter isString
		ifFalse: [ ^ pckgFilter anySatisfy: [ :f | e mooseName beginsWith: f ] ].
	pckgFilter = ''
		ifFalse: [ ^ e mooseName beginsWith: pckgFilter ].
	^ true