*Famix-Diff-Core
comeBeforeTheIndependentEntity: aFamixEntity
	"self and aFamixEntity are not in the same containment tree"

	^ (self typePriorityOf: self getFamixClass) < (self typePriorityOf: aFamixEntity getFamixClass)
		or: [ (self eq: aFamixEntity) and: [ self mooseName < aFamixEntity mooseName ] ]