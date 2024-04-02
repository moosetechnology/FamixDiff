Extension { #name : #FamixTTypedAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FamixTTypedAnnotationInstance >> compareMatchingAnnotationTypeWith: otherEntity resolver: resolver [

	<famixDiff: #identity priority: 15>
	self annotationType ifNil: [ ^ otherEntity annotationType isNil ].
	otherEntity annotationType ifNil: [ ^ false ].

	^ resolver is: self annotationType sameAs: otherEntity annotationType
]
