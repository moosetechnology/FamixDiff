*Famix-Diff-Core
containedEntities
	^ ((super containedEntities union: self childScopes) union: self globalVariables) union: self functions