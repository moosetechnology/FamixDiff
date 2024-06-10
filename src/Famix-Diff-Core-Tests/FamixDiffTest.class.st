Class {
	#name : #FamixDiffTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'result',
		'snapshot'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
FamixDiffTest >> createModelWith: somePackages [

	| importer model |
	importer := FamixStPharoImporterTask new
		            model: FamixStModel new;
		            addFromPackagesNamed: somePackages.
	importer importingContext mergeClassAndMetaclass.
	model := importer basicRun.
	self flag: #pharo11. "This is a hack because this attribute was removed from P12 and we want tests to work in P11 and P12 for now. So we remove it if we find it."
	(model entityNamed: #'Smalltalk::Object.DependentsFields') ifNotNil: [ :entity | model remove: entity ].
	^ model
]

{ #category : #tests }
FamixDiffTest >> createTestDiffForAdditionsAndRemovalsEdgeCases [

	| baseModel targetModel |
	self generateModel1.
	baseModel := self importModelNamed: 'base' fromPackages: {
			             self packageName1.
			             self packageName2 }.
	self packageOrganizer
		packageNamed: self packageName1 ifPresent: [ :package | package removeFromSystem ];
		packageNamed: self packageName2 ifPresent: [ :package | package removeFromSystem ].

	self generateModel2.
	targetModel := self importModelNamed: 'target' fromPackages: {
			               self packageName2.
			               self packageName3 }.
	self packageOrganizer
		packageNamed: self packageName2 ifPresent: [ :package | package removeFromSystem ];
		packageNamed: self packageName3 ifPresent: [ :package | package removeFromSystem ].

	snapshot
		baseModel: baseModel;
		targetModel: targetModel.
	self runDiff
]

{ #category : #tests }
FamixDiffTest >> generateModel1 [

	| c1 c2 |
	c1 := self class classInstaller make: [ :builder |
		      builder
			      name: #C1;
			      package: self packageName1 ].
	c1 compile: 'm1 ^ true'.
	c1 compile: 'm2 | temp | temp := false. ^ temp'.

	c2 := self class classInstaller make: [ :builder |
		      builder
			      name: #C2;
			      package: self packageName2 ].

	c2 compile: 'm3 ^ 1'.
	c2 compile: 'm4 | temp2 | temp2 := 3. ^ temp2'
]

{ #category : #tests }
FamixDiffTest >> generateModel2 [

	| c2 c3 |
	c2 := self class classInstaller make: [ :builder |
		      builder
			      name: #C2;
			      package: self packageName2 ].
	c2 compile: 'm2 | temp | temp := false. ^ temp'.
	c2 compile: 'm3 ^ 1'.

	c3 := self class classInstaller make: [ :builder |
		      builder
			      name: #C3;
			      package: self packageName3 ].
	c3 compile: 'm4 |temp2 | temp2 := 3. ^ temp2'.
	c3 compile: 'm5 |temp3 | temp3 := 5. ^ temp3'
]

{ #category : #accessing }
FamixDiffTest >> packageName1 [

	^ 'Famix-Diff-TestResource2-P1'
]

{ #category : #accessing }
FamixDiffTest >> packageName2 [

	^ 'Famix-Diff-TestResource2-P2'
]

{ #category : #accessing }
FamixDiffTest >> packageName3 [

	^ 'Famix-Diff-TestResource2-P3'
]

{ #category : #tests }
FamixDiffTest >> runDiff [
	^ result := snapshot run result
]

{ #category : #running }
FamixDiffTest >> setUp [

	super setUp.
	snapshot := FXDiff new
]

{ #category : #tests }
FamixDiffTest >> testAddedEntities [

	| addition |
	self createTestDiffForAdditionsAndRemovalsEdgeCases.
	addition := result additions.

	self assert: (addition select: [ :change | change baseEntity isKindOf: FamixStPackage ]) size equals: 1.
	self assert: (addition detect: [ :change | change baseEntity isKindOf: FamixStPackage ]) entity name equals: self packageName3.
	self assert: (addition select: [ :change | change baseEntity isKindOf: FamixStClass ]) size equals: 1.
	self assert: (addition detect: [ :change | change baseEntity isKindOf: FamixStClass ]) entity name equals: #C3.
	self assert: (addition select: [ :change | change baseEntity isKindOf: FamixStMethod ]) size equals: 1.
	self assert: (addition detect: [ :change | change baseEntity isKindOf: FamixStMethod ]) entity name equals: #m5.
	self assert: (addition select: [ :change | change baseEntity isKindOf: FamixStLocalVariable ]) size equals: 1.
	self assert: (addition detect: [ :change | change baseEntity isKindOf: FamixStLocalVariable ]) entity name equals: #temp3
]

{ #category : #tests }
FamixDiffTest >> testDiffAssociations [
	snapshot
		baseModel: (self createModelWith: #(#'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2'));
		targetModel: (self createModelWith: #(#'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2')).
	self runDiff.
	self assert: result associationChanges size equals: 6.
	self assert: (result associationChanges select: [ :c | c isAddition ]) size equals: 2.
	self assert: (result associationChanges select: [ :c | c isRemoval ]) size equals: 4
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesAddP1 [

	snapshot baseModel: MooseModel new.
	snapshot targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	self runDiff.
	self assert: result entityChanges size equals: 7.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 7 "Smalltalk P1 A2 B2 + stubs: ProtoObject Object Kernel"
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesDelP1 [

	snapshot baseModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	snapshot targetModel: MooseModel new.
	self runDiff.
	self assert: result entityChanges size equals: 7.
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 7 "Smalltalk P1 A2 B2 + stubs: ProtoObject Object Kernel"
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesMatchP1 [

	snapshot baseModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	snapshot targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	self runDiff.
	self assert: result entityChanges size equals: 7. "because in the old version result were duplicated"
	self assert: (result entityChanges select: [ :e | e isMatch ]) asSet size equals: 7
]

{ #category : #tests }
FamixDiffTest >> testDiffEntitiesP1P2P3 [

	snapshot baseModel: (self createModelWith: #( #'Famix-Diff-TestResource-P2' #'Famix-Diff-TestResource-P3' )).
	snapshot targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' )).
	self runDiff.
	self assert: result entityChanges size equals: 38.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 3. "P2 A2diff B2diff"
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 7. "P4 A4diff A4diff.att1 A4diff.b3() B4diff + annotations"
	self assert: (result entityChanges select: [ :e | e isMatch ]) size equals: 12 + 4 + 4 + 5 + 2 + 1.
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStLocalVariable ] ]) size equals: 12.
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStAttribute ] ]) size equals: 4. "A3.att1 A3.att2 B3.att1 B3.att2"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStMethod ] ]) size equals: 4. "A3.b2 A3.c3 B3.c3"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStClass ] ]) size equals: 5. "A3 B3 C3 Object ProtoObject"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStPackage ] ]) size equals: 2. "P3 Kernel"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStNamespace ] ]) size equals: 1 "Smalltalk"
]

{ #category : #'tests-run-entities' }
FamixDiffTest >> testMakeChangeWith [

	| entity change |
	entity := FamixStClass new
		          name: 'A';
		          yourself.
	change := FamixAddChange entity: entity.
	self
		assert: change class equals: FamixAddChange;
		assert: change entity equals: entity
]

{ #category : #'tests-run-entities' }
FamixDiffTest >> testMakeChangeWithWith [

	| entityA change entityB |
	entityA := FamixStClass new
		           name: 'A';
		           yourself.
	entityB := FamixStClass new
		           name: 'B';
		           yourself.
	change := FamixRenameChange base: entityA target: entityB.
	self
		assert: change class equals: FamixRenameChange;
		assert: change baseEntity equals: entityA;
		assert: change targetEntity equals: entityB
]

{ #category : #'tests-run-entities' }
FamixDiffTest >> testMatched [
	| entity |
	entity := FamixStNamedEntity new.
	self deny: (snapshot diffComputer matched: entity).
	snapshot diffComputer changesDico at: entity put: FamixMoveChange new.
	self assert: (snapshot diffComputer matched: entity)
]
