*Famix-Diff-Core
comeBeforeTheIndependentEntity: aFamixEntity
	"the super call have to be done after because of the name sort"
"(self typePriorityOf: self getFamixClass) < (self typePriorityOf: aFamixEntity getFamixClass)
		or: [ (self eq: aFamixEntity) and: [ self mooseName < aFamixEntity mooseName ] ]"
		
		
	^ (self comeAfterInInheritanceOrderThan: aFamixEntity) not
		and: [ (self comeBeforeInInheritanceOrderThan: aFamixEntity) or: [ super comeBeforeTheIndependentEntity: aFamixEntity ] ]