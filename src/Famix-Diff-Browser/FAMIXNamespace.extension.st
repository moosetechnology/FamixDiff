Extension { #name : #FAMIXNamespace }

{ #category : #'*Famix-Diff-Browser' }
FAMIXNamespace >> changeMetrics [
	^ super changeMetrics,{ 'Number of Lines of Code' -> #numberOfLinesOfCode. 
	'Number of classes' -> #numberOfClasses.
	'Afferent Coupling' -> #afferentCoupling. 
	'Efferent Coupling' ->#efferentCoupling
	}
]
