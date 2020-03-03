tests
testChangesWithChangeFilter
	self assert: diffBrowser displayedChanges size equals: 3.
	changesComputation changesFilter changes: diffBrowser displayedChanges.
	changesComputation changesFilter selection: { FamixMoveChange }.
	(diffBrowser displayedChanges: changesComputation changesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 0.
	self assert: diffBrowser displayedChanges size equals: changesComputation displayedChanges size.
	self assert: changesComputation changes size equals: 3.
	self assert: changesComputation changesFilter selection first equals: FamixMoveChange.
	changesComputation changesFilter selection: { FamixAddChange }.
	(diffBrowser displayedChanges: changesComputation changesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 3.