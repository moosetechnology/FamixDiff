sorting
sortChangesWith: aDictionaryOfSelections
	 | sortedChanges |
sortedChanges := self browser changesComputation sortChangesWith: {aDictionaryOfSelections values first. aDictionaryOfSelections values second}.
	self browser displayedChanges: sortedChanges