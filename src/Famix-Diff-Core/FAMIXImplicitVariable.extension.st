Extension { #name : #FAMIXImplicitVariable }

{ #category : #'*Famix-Diff-Core' }
FAMIXImplicitVariable >> famixDiffGuard [

	"Implicit variables cannot be renamed or moved."

	<famixDiffRename>
	<famixDiffMoved>
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXImplicitVariable >> moveMatch: otherEntity resolver: resolver [

	"no move possible for 'self' or 'super' "

	^ false
]
