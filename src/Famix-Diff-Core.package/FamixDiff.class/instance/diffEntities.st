run-entities
diffEntities
	| baseTodo targetTodo |
	"loops on this block"
	[ baseTodo := (self topEntitiesToMatch: self baseModel)
		asOrderedCollection.
	targetTodo := (self topEntitiesToMatch: self targetModel)
		asOrderedCollection.

	"as soon as one return true, go to next loop iteration"
	(self identityMatchesFrom: baseTodo to: targetTodo)
		or: [ (self renameMatchesFrom: baseTodo to: targetTodo)
				or: [ (self moveMatchesFrom: baseTodo)
						or: [ self moveMatchesTo: targetTodo ] ] ] ] whileTrue.

	"Each entities in base model that couldn't be matched with entity in target model is considered as removed."
	(self entitiesToMatch: self baseModel)
		do: [ :e | 
			self changesDico
				at: e
				put: (self makeChange: FamixRemovalChange with: e) ].

	"Each entities in target model that couldn't be matched with entity in base model is considered as added."
	(self entitiesToMatch: self targetModel)
		do:
			[ :e | self changesDico at: e put: (self makeChange: FamixAddChange with: e) ]