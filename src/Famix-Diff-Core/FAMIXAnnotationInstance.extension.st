Extension { #name : #FAMIXAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> moveMatch: anORClass givenChanges: aCollection tolerance: anInteger [
	"no move for this kind of entity..."

	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> renameMatch: aFAMIXMethod resolver: resolver [

	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> shouldBeConsideredForDiff [
	^true
]
