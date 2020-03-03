Class {
	#name : #FamixDiffSimpleSortTest,
	#superclass : #FamixDiffSortTest,
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffSimpleSortTest >> setUp [
	snapshot := FXDiff new
		diffTransformers: {FamixDiffSimpleChangesSorter};
		yourself
]
