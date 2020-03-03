*Famix-Diff-Core
comeBeforeOrIsEquivalent: aFamixChange
	^ (self comeBefore: aFamixChange)
		or: [ self class = aFamixChange class and: [ self entity comeBeforeEntityOrHasSameName: aFamixChange entity ] ]