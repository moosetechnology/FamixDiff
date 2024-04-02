Extension { #name : #FAMIXImplicitVariable }

{ #category : #'*Famix-Diff-Core' }
FAMIXImplicitVariable >> famixDiffGuard [

	"Implicit variables cannot be renamed or moved."

	<famixDiff: #rename priority: 0>
	<famixDiff: #move priority: 0>
	^ false
]
