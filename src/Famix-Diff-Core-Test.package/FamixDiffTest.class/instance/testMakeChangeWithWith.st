tests-run-entities
testMakeChangeWithWith
	| entityA change entityB |
	entityA := FAMIXClass new
					name: 'A';
					yourself.
	entityB := FAMIXClass new
					name: 'B';
					yourself.
	change := snapshot diffComputer makeChange: FamixRenameChange with: entityA with: entityB.
	self
		assert: change class equals: FamixRenameChange;
		assert: change baseEntity equals: entityA;
		assert: change targetEntity equals: entityB