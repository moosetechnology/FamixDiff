Extension { #name : 'FamixTImplicitVariable' }

{ #category : '*Famix-Diff-Core' }
FamixTImplicitVariable >> famixDiffGuardWith: anotherEntity resolver: aResolver [

	"Implicit variables cannot be renamed or moved."

	<famixDiff: #rename priority: 0>
	<famixDiff: #move priority: 0>
	^ false
]
