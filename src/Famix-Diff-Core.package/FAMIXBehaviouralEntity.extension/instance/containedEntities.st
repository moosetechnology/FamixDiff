*Famix-Diff-Core
containedEntities
	^ (super containedEntities union: self localVariables)  union: self parameters