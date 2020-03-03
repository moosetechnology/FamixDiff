*Famix-Diff-Core
getFamixClass
	^ self class isOrionClass
		ifTrue: [ self class superclass ]
		ifFalse: [ self class ]