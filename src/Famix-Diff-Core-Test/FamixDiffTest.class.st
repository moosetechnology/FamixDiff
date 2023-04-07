Class {
	#name : #FamixDiffTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'snapshot',
		'result'
	],
	#category : #'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffTest >> createModelWith: somePackages [ 
	| importer |
	importer := MoosePharoImporterTask new
		model: FAMIXModel new;
		addFromPackagesNamed: somePackages.
	importer importingContext mergeClassAndMetaclass.
	^importer basicRun

]

{ #category : #tests }
FamixDiffTest >> runDiff [
	^ result := snapshot run result
]

{ #category : #running }
FamixDiffTest >> setUp [ 
	snapshot := FXDiff new
]

{ #category : #tests }
FamixDiffTest >> testDiffAssociations [
	snapshot
		baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3'));
		targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3')).
	self runDiff.
	self assert: result assocChanges size equals: 6.
	self assert: (result assocChanges select: [ :c | c isAddition ]) size equals: 2.
	self assert: (result assocChanges select: [ :c | c isRemoval ]) size equals: 4
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesAddP2 [
	snapshot baseModel: MooseModel new.
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	self runDiff.
	self assert: result entityChanges size equals: 8.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 8	"Smalltalk P2 A2 B2 + stubs: ProtoObject Object Kernel Object.DependentsFields"
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesDelP2 [
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	snapshot targetModel: MooseModel new.
	self runDiff.
	self assert: result entityChanges size equals: 8.
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 8	"Smalltalk P2 A2 B2 + stubs: ProtoObject Object Kernel Object.DependentsFields"
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesMatchP2 [
	snapshot baseModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	snapshot targetModel: (self createModelWith: #(#'Moose-TestResources-ModelDiff-P2')).
	self runDiff.
	self assert: result entityChanges size equals: 16 / 2 "because in the old version result were duplicated".
	self assert: (result entityChanges select: [ :e | e isMatch ]) asSet size equals: 8
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesP2P3P4 [
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
]

{ #category : #'tests-run-entities' }
FamixDiffTest >> testMakeChangeWith [
	| entity change |
	entity := FAMIXClass new
					name: 'A';
					yourself.
	change := snapshot diffComputer makeChange: FamixAddChange with: entity.
	self
		assert: change class equals: FamixAddChange;
		assert: change entity equals: entity
]

{ #category : #'tests-run-entities' }
FamixDiffTest >> testMakeChangeWithWith [
	| entityA change entityB |
	entityA := FAMIXClass new
					name: 'A';
					yourself.
	entityB := FAMIXClass new
					name: 'B';
					yourself.
	change := snapshot diffComputer makeChange: FamixRenameChange with: entityA with: entityB.
	self
		assert: change class equals: FamixRenameChange;
		assert: change baseEntity equals: entityA;
		assert: change targetEntity equals: entityB
]

{ #category : #'tests-run-entities' }
FamixDiffTest >> testMatched [
	| entity |
	entity := FAMIXNamedEntity new.
	self deny: (snapshot diffComputer matched: entity).
	snapshot diffComputer changesDico at: entity put: FamixMoveChange new.
	self assert: (snapshot diffComputer matched: entity)
]
