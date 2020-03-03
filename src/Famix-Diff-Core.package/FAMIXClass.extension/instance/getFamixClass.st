*Famix-Diff-Core
getFamixClass
	self isAnonymousClass ifTrue: [ ^ #FAMIXAnonymousClass ].
	self isInnerClass ifTrue: [ ^ #FAMIXInnerClass ].
	 ^ super getFamixClass.
	