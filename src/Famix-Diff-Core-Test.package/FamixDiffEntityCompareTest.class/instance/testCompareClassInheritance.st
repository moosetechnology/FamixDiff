tests
testCompareClassInheritance
	| superClass subClass |
	superClass := self model entityNamed: 'Smalltalk::B4diff'.
	subClass := self model entityNamed: 'Smalltalk::A4diff'.
	self assert: (superClass comeBeforeEntity: subClass).
	self deny: (subClass comeBeforeEntity: superClass)