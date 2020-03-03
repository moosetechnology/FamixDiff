Extension { #name : #FAMIXMethod }

{ #category : #'*Famix-Diff-Core' }
FAMIXMethod >> getFamixClass [
	^ self belongsTo isAnonymousClass ifTrue: [  #FAMIXMethodInAnonymousClass ]
	ifFalse: [ super getFamixClass ].

]
