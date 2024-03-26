Extension { #name : #FAMIXImplicitVariable }

{ #category : #'*Famix-Diff-Core' }
FAMIXImplicitVariable >> moveMatch: otherEntity givenChanges: changes tolerance: percentage [
	"no move possible for 'self' or 'super' "
	^ false
]
