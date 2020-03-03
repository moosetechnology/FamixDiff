*Famix-Diff-Core
comeBeforeEntity: aFamixEntity
	^ (self eq: aFamixEntity)
		ifTrue: [ self mooseName < aFamixEntity mooseName ]
		ifFalse: [ (self typePriorityOf: self getFamixClass) < (self typePriorityOf: aFamixEntity getFamixClass) ]