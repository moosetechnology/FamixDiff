tests-run-entities
testMatched
	| entity |
	entity := FAMIXNamedEntity new.
	self deny: (snapshot diffComputer matched: entity).
	snapshot diffComputer changesDico at: entity put: FamixMoveChange new.
	self assert: (snapshot diffComputer matched: entity)