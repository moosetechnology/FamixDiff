Extension { #name : #FAMIXType }

{ #category : #'*Famix-Diff-Browser' }
FAMIXType >> changeMetrics [
	^ super changeMetrics,{ 'Number of Lines of Code' -> #numberOfLinesOfCode. 
	'Number of children' -> #numberOfChildren. 
	'Number of attributes' -> #numberOfAttributes . 
	'Number of methods' -> #numberOfMethods. 
	'Number of direct subclasses' -> #numberOfDirectSubclasses.
	'Fan in' -> #fanIn. 
	'Fan out' ->#fanOut
	}
]
