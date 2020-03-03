running
setUp
	snapshot := FXDiff new
		diffTransformers: {FamixDiffChangesSorter};
		yourself