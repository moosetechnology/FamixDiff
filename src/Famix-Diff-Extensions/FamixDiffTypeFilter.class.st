"
Filter types that satisfy the user selected types.

"
Class {
	#name : #FamixDiffTypeFilter,
	#superclass : #FamixDiffFilter,
	#category : 'Famix-Diff-Extensions'
}

{ #category : #result }
FamixDiffTypeFilter >> computeResult [
	^ self changes select: [ :aChange | self selection includes: aChange entity class  ].

]
