Extension { #name : #FamixTTypedAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FamixTTypedAnnotationInstance >> compareMatchingAnnotationTypeWith: otherEntity givenChanges: changes [

	<famixDiffIdentity>
	self annotationType ifNil: [ ^ otherEntity annotationType isNil ].
	otherEntity annotationType ifNil: [ ^ false ].

	(self annotationType isStub or: [ otherEntity annotationType isStub ]) ifTrue: [ ^ self annotationType mooseName = otherEntity annotationType mooseName ].

	^ (changes at: self annotationType ifAbsent: [ ^ false ]) = (changes at: otherEntity annotationType ifAbsent: [ ^ false ])
]
