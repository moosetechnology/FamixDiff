initialization
initializeDiffwith: base and: target
	(base isKindOf: MooseModel) should beTrue.
	(target isKindOf: MooseModel) should beTrue.
	base == target
		ifTrue: [ displayedChanges := #().
			^ self ].
	displayedChanges := nil.
	Cursor wait showWhile: [ famixDiff := FXDiff runOnBaseModel: base targetModel: target ]