tests-run-entities
testMakeChangeWith
	| entity change |
	entity := FAMIXClass new
					name: 'A';
					yourself.
	change := snapshot diffComputer makeChange: FamixAddChange with: entity.
	self
		assert: change class equals: FamixAddChange;
		assert: change entity equals: entity