run-associations
addAssociations: assocs
	assocs do: [ :a | self assocChanges add: (FamixAddChange new entity: a ; yourself) ]