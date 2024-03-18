Extension { #name : #FAMIXAnnotationInstance }

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> identityMatch: otherEntity givenChanges: changes [

	"Same class, same parents"

	self class = otherEntity class ifFalse: [ ^ false ].
	^ (self isMatchingMyParent: self belongsTo with: otherEntity belongsTo givenChanges: changes) and: [ 
		  self isMatchingMyParent: self annotationType with: otherEntity annotationType givenChanges: changes ]
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAnnotationInstance >> isMatchingMyParent: myParent with: otherEntityParent givenChanges: changes [
	myParent ifNil: [ ^ otherEntityParent isNil ].
	otherEntityParent ifNil: [ ^ false ].
	myParent isStub
		ifTrue: [ ^ myParent mooseName = otherEntityParent mooseName ].
	otherEntityParent isStub
		ifTrue: [ ^ myParent mooseName = otherEntityParent mooseName ].

	^ (changes at: myParent ifAbsent: [ ^ false ]) = (changes at: otherEntityParent ifAbsent: [ ^ false ])
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
