run-entities
topEntitiesToMatch: aModel
	"topmost, not stub, not matched entities"
	^ (self entitiesToMatch: aModel)
		select: [:e ||parent|
				parent := e belongsTo.
				(self entityToMatch: parent) not or: [self matched: parent] ]
