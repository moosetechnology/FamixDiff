tests
testCompareMoveVersion
	| att cl vs mv tmpModel |
	tmpModel := MooseModel new.
	att := FAMIXAttribute new parentType: FAMIXClass new; mooseModel: tmpModel; yourself.
	cl := FAMIXClass new name: 'cl'; container: FAMIXPackage new; mooseModel: tmpModel; 
			yourself.
	vs := FamixVersionChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self deny: (vs comeBefore: mv).
	self assert: (mv comeBefore: vs)