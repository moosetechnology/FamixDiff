"
A FamixDiffResultTest is a test class for testing the behavior of FamixDiffResult
"
Class {
	#name : 'FamixDiffResultTest',
	#superclass : 'AbstractFamixDiffTest',
	#instVars : [
		'result'
	],
	#category : 'Famix-Diff-Core-Tests',
	#package : 'Famix-Diff-Core-Tests'
}

{ #category : 'running' }
FamixDiffResultTest >> setUp [

	| model1 model2 |
	super setUp.
	model1 := self importModelNamed: 'base' fromPackages: #( #'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2' ).
	model2 := self importModelNamed: 'target' fromPackages: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' ).
	result := (FXDiff baseModel: model1 targetModel: model2)
		          considerComments;
		          run;
		          result
]

{ #category : 'tests' }
FamixDiffResultTest >> testAdditions [

	| additions |
	additions := result additions.

	self assert: additions size equals: 5.
	additions do: [ :change |
		self assert: change isAddition ].
	self assert: additions class equals: result class
]

{ #category : 'tests' }
FamixDiffResultTest >> testGroupAdditionsAndRemovalsByRoots [

	| subResult |
	subResult := result groupAdditionsAndRemovalsByRoots.
	self assert: subResult additions size equals: 1.
	self assert: subResult additions anyOne entity mooseName equals: #'Famix-Diff-TestResource-P1'.
	self assert: subResult removals size equals: 3 "1 package and a pragma with its type"
]

{ #category : 'tests' }
FamixDiffResultTest >> testIdentities [

	| additions |
	additions := result identities.

	self assert: additions size equals: 33.
	additions do: [ :change | self assert: change isUnchanged ].
	self assert: additions class equals: result class
]

{ #category : 'tests' }
FamixDiffResultTest >> testMoves [

	| moves |
	moves := result moves.

	self assert: moves size equals: 0.
	moves do: [ :change |
		self assert: change isMove ].
	self assert: moves class equals: result class
]

{ #category : 'tests' }
FamixDiffResultTest >> testRemovals [

	| removals |
	removals := result removals.

	self assert: removals size equals: 12.
	removals do: [ :change | 
		self assert: change isRemoval ].
	self assert: removals class equals: result class
]

{ #category : 'tests' }
FamixDiffResultTest >> testRenames [

	| moves |
	moves := result renames.
	
	self assert: moves size equals: 0.
	moves do: [ :change | 
		self assert: change isRename ].
	self assert: moves class equals: result class
]

{ #category : 'tests' }
FamixDiffResultTest >> testWithoutStubs [

	| withoutStubs |
	self assert: (result anySatisfy: [ :change | change entity isStub ]).

	"We want a new collection, not to update the original one."
	withoutStubs := result withoutStubs.

	self deny: result identicalTo: withoutStubs.
	self assert: (withoutStubs noneSatisfy: [ :change | change entity isStub ]).
	self assert: withoutStubs class equals: result class
]
