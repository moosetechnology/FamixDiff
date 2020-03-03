tests
testCompareClassAssociation
	| ass1 cl ass2 ass3 |
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	ass1 := cl incomingReferences first.
	self assert: (cl comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: cl).
	ass2 := cl outgoingInvocations first.
	self assert: (cl comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: cl).
	ass3 := cl incomingAccesses first.
	self assert: (cl comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: cl)