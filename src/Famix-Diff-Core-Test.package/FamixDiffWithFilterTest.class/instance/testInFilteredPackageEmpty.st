tests
testInFilteredPackageEmpty
	<expectedFailure>
	self flag: 'VB: I do not understand the goal of the tested class...'.
	snapshot base: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3' #'Moose-TestResources-ModelDiff-P4' )).
	
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Moose-TestResources-ModelDiff-P3')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff')).
	self assert: (snapshot inFilteredPackage: (snapshot base entityNamed: 'Smalltalk::A3diff.c3()')).