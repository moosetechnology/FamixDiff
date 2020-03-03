*Famix-Diff-Core
comeBefore: aFamixChange
	^ (self entity eq: aFamixChange entity)
		ifTrue:
			[ (self typeOrderPriority indexOf: self class)
				< (self typeOrderPriority indexOf: aFamixChange class) ]
		ifFalse: [ self entity comeBeforeEntity: aFamixChange entity ]