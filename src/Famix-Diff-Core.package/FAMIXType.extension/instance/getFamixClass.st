*Famix-Diff-Core
getFamixClass
	(self container isKindOf: FAMIXMethod)
		ifTrue: [ ^ #FAMIXTypeInnerMethod ].
	^ super getFamixClass