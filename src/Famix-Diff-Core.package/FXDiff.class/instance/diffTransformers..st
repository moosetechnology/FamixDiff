accessing
diffTransformers: aCollectionOfPostOperators
	self assert: (aCollectionOfPostOperators isNil or: [ aCollectionOfPostOperators isCollection ]) description: 'PostOperators should be a collection...'.
	diffTransformers := aCollectionOfPostOperators
		ifNotNil: [ aCollectionOfPostOperators
				collect: [ :aClass | 
					aClass new
						orchestrator: self;
						yourself ] ]