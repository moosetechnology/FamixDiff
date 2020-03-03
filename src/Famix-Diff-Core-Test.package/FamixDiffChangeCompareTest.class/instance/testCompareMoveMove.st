tests
testCompareMoveMove
	| att cl mv1 mv tmpModel |
	tmpModel := MooseModel new.
	att := FAMIXAttribute new name: 'att' ; parentType: FAMIXClass new; mooseModel: tmpModel ; yourself.
	cl := FAMIXClass new name: 'cl' ; container: FAMIXPackage new; mooseModel: tmpModel ; yourself.
	mv1 := FamixMoveChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: mv1 ).
	self deny: (mv1 comeBefore: mv)