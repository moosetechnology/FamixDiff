tests
testDiffEntitiesP2P3P4
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P3' #'Moose-TestResources-ModelDiff-P4')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	self assert: result entityChanges size equals: 39.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 3.	"P2 A2diff B2diff"
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 7.	"P4 A4diff A4diff.att1 A4diff.b3() B4diff + annotations"
	self assert: (result entityChanges select: [ :e | e isMatch ]) size equals: 12 + 5 + 4 + 5 + 2 + 1.
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FAMIXLocalVariable ] ]) size equals: 12.
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FAMIXAttribute ] ]) size equals: 5.	"A3.att1 A3.att2 B3.att1 B3.att2 Object.DependentsFields"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FAMIXMethod ] ]) size equals: 4.	"A3.b2 A3.c3 B3.c3"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FAMIXClass ] ]) size equals: 5.	"A3 B3 C3 Object ProtoObject"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FAMIXPackage ] ]) size equals: 2.	"P3 Kernel"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FAMIXNamespace ] ]) size equals: 1	"Smalltalk"