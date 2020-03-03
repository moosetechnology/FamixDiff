*Famix-Diff-Core
comeBeforeEntityOrHasSameName: aFamixEntity
	^ (self comeBeforeEntity: aFamixEntity ) or: [ self mooseName =  aFamixEntity mooseName]