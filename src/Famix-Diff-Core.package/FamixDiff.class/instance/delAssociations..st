run-associations
delAssociations: assocs
	assocs
		do: [ :a | 
			self assocChanges
				add:
					(FamixRemovalChange new
						entity: a;
						yourself) ]