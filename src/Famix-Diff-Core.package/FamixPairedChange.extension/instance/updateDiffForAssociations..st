*Famix-Diff-Core
updateDiffForAssociations: aFamixDiff
	aFamixDiff checkAssocsMatches: self baseEntity queryAllLocalOutgoing with: self targetEntity queryAllLocalOutgoing tolerance: 0