Class {
	#name : 'FamixDiffTestModelsGenerator1',
	#superclass : 'TestResource',
	#instVars : [
		'b3',
		'a3',
		'c3',
		'a4'
	],
	#category : 'Famix-Diff-Core-Tests',
	#package : 'Famix-Diff-Core-Tests'
}

{ #category : 'running' }
FamixDiffTestModelsGenerator1 >> generateClasses [

	self class classInstaller
		make: [ :builder |
			builder
				name: #A2diff;
				package: self packageName1 ];
		make: [ :builder |
			builder
				name: #B2diff;
				package: self packageName1 ].
	a3 := self class classInstaller make: [ :builder |
		      builder
			      name: #A3diff;
			      slots: { #att1. #att2 };
			      package: self packageName2 ].
	b3 := self class classInstaller make: [ :builder |
		      builder
			      name: #B3diff;
			      slots: { #att1. #att2 };
			      package: self packageName2 ].
	c3 := self class classInstaller make: [ :builder |
		      builder
			      name: #C3diff;
			      package: self packageName2 ].
	self class classInstaller make: [ :builder |
		builder
			name: #B4diff;
			package: self packageName3 ].
	a4 := self class classInstaller make: [ :builder |
		      builder
			      superclassName: #B4diff;
			      name: #A4diff;
			      slots: { #att1 };
			      package: self packageName3 ]
]

{ #category : 'running' }
FamixDiffTestModelsGenerator1 >> generateMethods [

	a3 compile: 'b3
	B3diff new.
	att2:= ''toto'''.

	a3 compile: 'c3
	"comment stating purpose of message"
	| toto var2 var3 var4 |

	toto := C3diff new.'.

	b3 compile: 'c3
	"comment stating purpose of message"
	| toto var2 var3 var4 |

	C3diff new.'.

	c3 compile: 'a3
	"comment stating purpose of message"
	| toto var2 var3 var4 |

	A3diff new.'.

	a4 compile: 'b3
	"comment stating purpose of message"
	<pragmaTotestAnnotations>
	B3diff new.'
]

{ #category : 'accessing' }
FamixDiffTestModelsGenerator1 >> packageName1 [

	^ 'Famix-Diff-TestResource-P1'
]

{ #category : 'accessing' }
FamixDiffTestModelsGenerator1 >> packageName2 [

	^ 'Famix-Diff-TestResource-P2'
]

{ #category : 'accessing' }
FamixDiffTestModelsGenerator1 >> packageName3 [

	^ 'Famix-Diff-TestResource-P3'
]

{ #category : 'running' }
FamixDiffTestModelsGenerator1 >> setUp [

	super setUp.
	self
		generateClasses;
		generateMethods
]

{ #category : 'running' }
FamixDiffTestModelsGenerator1 >> tearDown [

	self packageOrganizer
		packageNamed: self packageName1 ifPresent: [ :package | package removeFromSystem ];
		packageNamed: self packageName2 ifPresent: [ :package | package removeFromSystem ];
		packageNamed: self packageName3 ifPresent: [ :package | package removeFromSystem ].

	super tearDown
]
