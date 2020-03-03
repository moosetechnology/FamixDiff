accessing
run
	self sortChanges.
	self result: (FamixDiffResult withAll: self calculateSortedChanges)