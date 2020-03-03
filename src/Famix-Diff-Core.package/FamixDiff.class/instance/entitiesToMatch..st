run-entities
entitiesToMatch: aModel
	"not stub, not matched entities"
	^ aModel entities select: [:e | self entityToMatch: e ]
