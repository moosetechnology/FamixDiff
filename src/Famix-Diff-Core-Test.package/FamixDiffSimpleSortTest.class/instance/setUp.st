running
setUp
	snapshot := FXDiff new
		diffTransformers: {FamixDiffSimpleChangesSorter};
		yourself