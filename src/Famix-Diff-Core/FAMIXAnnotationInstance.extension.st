Extension { #name : #FAMIXAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> compareMatchingAnnotationTypeWith: otherEntity givenChanges: changes [

	<famixDiffIdentity>
	self annotationType ifNil: [ ^ otherEntity annotationType isNil ].
	otherEntity annotationType ifNil: [ ^ false ].

	(self annotationType isStub or: [ otherEntity annotationType isStub ]) ifTrue: [ ^ self annotationType mooseName = otherEntity annotationType mooseName ].

	^ (changes at: self annotationType ifAbsent: [ ^ false ]) = (changes at: otherEntity annotationType ifAbsent: [ ^ false ])
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> moveMatch: anORClass givenChanges: aCollection tolerance: anInteger [
	"no move for this kind of entity..."

	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> renameMatch: aFAMIXMethod givenChanges: aCollection tolerance: anInteger [
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> shouldBeConsideredForDiff [
	^true
]
