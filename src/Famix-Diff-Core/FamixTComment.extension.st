Extension { #name : #FamixTComment }

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> isIdenticalTo: otherEntity resolver: resolver [

	(self hasSameClassAs: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	(self compareParentsWith: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	(self content = otherEntity content) ifFalse: [ ^ false ].
	 ^ true
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> isRenameOf: otherEntity resolver: resolver [
	"using Pharo diff to compute differences
	 percentage of differences (compared to max size) must be less that `resolver tolerance` "

	| diffs sizeMax |
	diffs := DiffBuilder new
		diffFrom: self content
		to: otherEntity content.

	sizeMax := (self content size) max: (otherEntity content size).

	^(diffs size / sizeMax) asFloat <= (resolver tolerance)
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> moveMatch: otherEntity resolver: resolver [
	"Comments are never moved"

	^false
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> renameMatch: otherEntity resolver: resolver [
	"we consider a 'RenameMatch' between 2 comments if there is 'not too much' differences in their texts"

	((otherEntity usesFamixTrait: FamixTComment) and:
	[ self content ~= otherEntity content ])
		ifFalse: [ ^ false ].

	"See comment in #identityMatch:resolver: to understand what we are doing here"
	^self isRenameOf: otherEntity resolver: resolver
]

{ #category : #'*Famix-Diff-Core' }
FamixTComment >> shouldBeConsideredForDiff [
	^ true
]
