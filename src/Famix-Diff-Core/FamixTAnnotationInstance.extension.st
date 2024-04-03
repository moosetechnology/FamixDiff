Extension { #name : #FamixTAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FamixTAnnotationInstance >> famixDiffGuard [

	"Annotation instances cannot be renamed or moved."

	<famixDiff: #rename priority: 0>
	<famixDiff: #move priority: 0>
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FamixTAnnotationInstance >> shouldBeConsideredForDiff [
	^true
]
