computation
binaryFindBlock: aKey
	^ [ :aNode | 
	aNode entity = aKey
		ifTrue: [ 0 ]
		ifFalse: [ aKey hash < aNode entity hash
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ] ]