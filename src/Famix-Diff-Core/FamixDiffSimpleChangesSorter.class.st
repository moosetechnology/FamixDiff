Class {
	#name : #FamixDiffSimpleChangesSorter,
	#superclass : #FamixDiffAbstractPostOperator,
	#category : 'Famix-Diff-Core'
}

{ #category : #sorting }
FamixDiffSimpleChangesSorter >> entitiesAddAndChangesSorted [
	^ (self result entityChanges reject: [ :change | change isRemoval ]) asSet
		sorted: [ :a :b | a comeBeforeOrIsEquivalent: b ]
]

{ #category : #'as yet unclassified' }
FamixDiffSimpleChangesSorter >> run [
	| coll |
	coll := OrderedCollection new.
	coll addAll: self entitiesAddAndChangesSorted.
	coll addAll: (self result assocChanges reject: [ :change | change isRemoval ]) asSet.
	coll addAll: (self result assocChanges select: [ :change | change isRemoval ]) asSet.
	coll
		addAll:
			((self result entityChanges select: [ :change | change isRemoval ]) asSet
				sorted: [ :a :b | a comeBeforeOrIsEquivalent: b ]) reverse.
	^ self result: (FamixDiffResult withAll: coll)	"coll   sort: [ :aFamixChange1 :aFamixChange2 | aFamixChange1 < aFamixChange2 ]"
]

{ #category : #'as yet unclassified' }
FamixDiffSimpleChangesSorter >> sort [
	| coll |
	coll := OrderedCollection new.
	coll addAll: self entitiesAddAndChangesSorted.
	coll
		addAll: (self result assocChanges reject: [ :change | change isRemoval ]) asSet.
	coll
		addAll: (self result assocChanges select: [ :change | change isRemoval ]) asSet.
	coll
		addAll:
			((self result entityChanges select: [ :change | change isRemoval ]) asSet
				sorted: [ :a :b | a comeBeforeOrIsEquivalent: b ]) reverse.
	^ coll	"coll   sort: [ :aFamixChange1 :aFamixChange2 | aFamixChange1 < aFamixChange2 ]"
]
