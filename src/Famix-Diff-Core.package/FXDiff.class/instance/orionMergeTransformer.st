for testing
orionMergeTransformer
	^ self diffTransformers
		detect: [ :e | (e isKindOf: OrionMerge) or: [ e isKindOf: OrionMergeWithVisitor ] ]