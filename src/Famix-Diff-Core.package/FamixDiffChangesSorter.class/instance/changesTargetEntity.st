accessing
changesTargetEntity
	^ changesTargetEntity ifNil: [ changesTargetEntity := self changes copy ]