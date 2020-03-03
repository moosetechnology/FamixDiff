Extension { #name : #FAMIXBehaviouralEntity }

{ #category : #'*Famix-Diff-Browser' }
FAMIXBehaviouralEntity >> changeMetrics [
	^ super changeMetrics, {'Number of Lines of Code' -> #numberOfLinesOfCode. 
	'Cyclomatic complexity' -> #cyclomaticComplexity. 
	'Number of parameters' -> #numberOfParameters. 
	'Number of Outgoing invovations' -> #numberOfOutgoingInvocations. 
	'Number of outgoing accesses' -> #numberOfAccesses}
]
