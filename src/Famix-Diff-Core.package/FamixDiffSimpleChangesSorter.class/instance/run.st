as yet unclassified
run
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