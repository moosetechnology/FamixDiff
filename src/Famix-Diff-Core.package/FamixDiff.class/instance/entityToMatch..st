run-entities
entityToMatch: entity
	"not stub, not matched"
	^ entity isNotNil
		and: [ (entity shouldBeConsideredForDiff) 
		and: [ (self matched: entity) not ] ]