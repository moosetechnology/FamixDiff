*Famix-Diff-Browser
entityChangeIndicators
	^ self entity changeMetrics collect: [ :assoc | FamixDiffIndicator selector: assoc value label: assoc key ]