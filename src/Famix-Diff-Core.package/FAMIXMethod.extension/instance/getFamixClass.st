*Famix-Diff-Core
getFamixClass
	^ self belongsTo isAnonymousClass ifTrue: [  #FAMIXMethodInAnonymousClass ]
	ifFalse: [ super getFamixClass ].
