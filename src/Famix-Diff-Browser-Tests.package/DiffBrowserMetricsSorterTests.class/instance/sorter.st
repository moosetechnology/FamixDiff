accessing
sorter
	^ sorter ifNil: [sorter := FamixDiffMetricsSorter new changes: diffBrowser displayedChanges; selection: {#nameLength.'Descending'}; yourself]