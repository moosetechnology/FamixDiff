Extension { #name : #FAMIXClass }

{ #category : #'*Famix-Diff-Core' }
FAMIXClass >> getFamixClass [
	self isAnonymousClass ifTrue: [ ^ #FAMIXAnonymousClass ].
	self isInnerClass ifTrue: [ ^ #FAMIXInnerClass ].
	 ^ super getFamixClass.
	
]

{ #category : #'*Famix-Diff-Core' }
FAMIXClass >> parentContainer [ 
	^ self parentPackage ifNil: [ super parentContainer ]
]
