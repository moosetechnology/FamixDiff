Extension { #name : #MooseEntity }

{ #category : #'*Famix-Diff-Core' }
MooseEntity >> shouldBeConsideredForDiff [
	self flag: #todo.
	^ false
]
