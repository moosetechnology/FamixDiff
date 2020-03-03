*Famix-Diff-Core
isRealClass
	^ self isInnerClass not and: [ self isAnonymousClass not and: [ self isParameterizableClass not ] ]