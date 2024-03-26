Extension { #name : #FamixTTypedAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FamixTTypedAnnotationInstance >> compareMatchingAnnotationTypeWith: otherEntity resolver: resolver [

	<famixDiffIdentity>
	self annotationType ifNil: [ ^ otherEntity annotationType isNil ].
	otherEntity annotationType ifNil: [ ^ false ].

	^ resolver is: self annotationType sameAs: otherEntity annotationType
]
