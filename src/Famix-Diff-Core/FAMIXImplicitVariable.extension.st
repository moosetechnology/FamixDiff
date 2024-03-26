Extension { #name : #FAMIXImplicitVariable }

{ #category : #'*Famix-Diff-Core' }
FAMIXImplicitVariable >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [
	"no move possible for 'self' or 'super' "
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXImplicitVariable >> renameMatch: otherEntity resolver: resolver [

	"no rename possible for 'self' or 'super' "

	^ false
]
