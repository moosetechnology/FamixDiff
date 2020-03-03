*Famix-Diff-Browser
changeMetrics
	^ super changeMetrics,{ 'Number of Lines of Code' -> #numberOfLinesOfCode. 
	'Number of classes' -> #numberOfClasses.
	'Afferent Coupling' -> #afferentCoupling. 
	'Efferent Coupling' ->#efferentCoupling
	}