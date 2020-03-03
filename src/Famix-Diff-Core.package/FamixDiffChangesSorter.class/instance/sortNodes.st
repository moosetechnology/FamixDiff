computation
sortNodes
	| sortedNodes |
	sortedNodes := graph nodes sorted: [ :node1 :node2 | node1 pathWeight <= node2 pathWeight ].
	^ sortedNodes collect: #model