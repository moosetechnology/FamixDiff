tests
testCompareAddVersion
	| att cl add1 vs n1 tmpModel |
	tmpModel := MooseModel new.
	att := FAMIXAttribute new parentType: (FAMIXClass new); mooseModel: tmpModel; yourself.
	n1 := FAMIXNamespace new mooseModel: tmpModel; yourself.
	cl := FAMIXClass new name: #C1; container: n1; mooseModel: tmpModel; yourself.
	
	add1 := FamixAddChange new entity: att.
	vs := FamixVersionChange new entity: cl.
	self assert: (vs comeBefore: add1 ).
	self deny: (add1 comeBefore: vs)