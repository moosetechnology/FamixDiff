computation
buildEdges
	graph nodes
		do: [ :node | 
			graph
				edges: node model edgesToRelatedItems
				from: [ :assoc | self findInChanges: assoc key ]
				to: [ :assoc |self findInChanges: assoc value ] ] 