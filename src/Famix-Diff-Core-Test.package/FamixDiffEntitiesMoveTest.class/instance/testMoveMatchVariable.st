tests
testMoveMatchVariable
	| var1 var2 |
	"creating fake accesses because maching of variables depend on them
	 First we don't create enough accesses (need at least 3)"
	var1 := snapshot baseModel entityNamed: 'Smalltalk::A3diff.c3().toto'.
	FAMIXAccess new
		variable: var1;
		accessor: (snapshot baseModel entityNamed: 'Smalltalk::A3diff.b2()').
	var2 := snapshot targetModel
		entityNamed: 'Smalltalk::B3diff.c3().toto'.
	FAMIXAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.c3()').
	FAMIXAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::A3diff.b2()').
	self
		deny: (var1 moveMatch: var2 givenChanges: testChanges tolerance: 0).
	self
		deny: (var2 moveMatch: var1 givenChanges: testChanges tolerance: 0).	"now create one more access"
	FAMIXAccess new
		variable: var1;
		accessor: (snapshot baseModel entityNamed: 'Smalltalk::B3diff.c3()').
	FAMIXAccess new
		variable: var2;
		accessor: (snapshot targetModel entityNamed: 'Smalltalk::B3diff.c3()').
	self
		assert: (var1 moveMatch: var2 givenChanges: testChanges tolerance: 0).
	self
		assert: (var2 moveMatch: var1 givenChanges: testChanges tolerance: 0)