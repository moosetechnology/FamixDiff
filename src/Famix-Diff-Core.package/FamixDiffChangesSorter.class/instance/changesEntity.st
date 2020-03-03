accessing
changesEntity
	^ changesEntity ifNil: [ changesEntity := self changes copy ]