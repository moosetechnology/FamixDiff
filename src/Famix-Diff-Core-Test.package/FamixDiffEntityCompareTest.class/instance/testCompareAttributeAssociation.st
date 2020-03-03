tests
testCompareAttributeAssociation
	| ass1 att ass2 ass3 |
	ass1 := FAMIXAccess new.
	att := FAMIXAttribute new.
	self assert: (att comeBeforeEntity: ass1).
	self deny: (ass1 comeBeforeEntity: att).
	ass2 := FAMIXInvocation new.
	self assert: (att comeBeforeEntity: ass2).
	self deny: (ass2 comeBeforeEntity: att).
	ass3 := FAMIXReference new.
	self assert: (att comeBeforeEntity: ass3).
	self deny: (ass3 comeBeforeEntity: att)