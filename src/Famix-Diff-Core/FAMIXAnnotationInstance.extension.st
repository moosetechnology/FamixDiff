Extension { #name : #FAMIXAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> famixDiffGuard [

	"Annotation instances cannot be renamed or moved."

	<famixDiff: #rename priority: 0>
	<famixDiff: #move priority: 0>
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> shouldBeConsideredForDiff [
	^true
]
