Class {
	#name : 'FamixDiffTest',
	#superclass : 'AbstractFamixDiffTest',
	#instVars : [
		'result',
		'snapshot'
	],
	#category : 'Famix-Diff-Core-Tests',
	#package : 'Famix-Diff-Core-Tests'
}

{ #category : 'running' }
FamixDiffTest >> changes: aCollection ofType: aClass [

	^aCollection select: [ :change |
		change baseEntity isKindOf: aClass ]
]

{ #category : 'running' }
FamixDiffTest >> createModelWith: somePackages [

	| importer model |
	importer := FamixStPharoImporterTask new
		            model: FamixStModel new;
		            addFromPackagesNamed: somePackages.
	importer importingContext mergeClassAndMetaclass.
	model := importer basicRun.
	self flag: #pharo11. "This is a hack because this attribute was removed from P12 and we want tests to work in P11 and P12 for now. So we remove it if we find it."
	(model entityNamed: #'Smalltalk.Object.DependentsFields') ifNotNil: [ :entity | model remove: entity ].
	^ model
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'accessing' }
FamixDiffTest >> packageName1 [

	^ 'Famix-Diff-TestResource2-P1'
]

{ #category : 'accessing' }
FamixDiffTest >> packageName2 [

	^ 'Famix-Diff-TestResource2-P2'
]

{ #category : 'accessing' }
FamixDiffTest >> packageName3 [

	^ 'Famix-Diff-TestResource2-P3'
]

{ #category : 'tests' }
FamixDiffTest >> runDiff [

	| baseEntitiesToMatch targetEntitiesToMatch |
	baseEntitiesToMatch := snapshot resolver entitiesToMatchIn: snapshot baseModel.
	targetEntitiesToMatch := snapshot resolver entitiesToMatchIn: snapshot targetModel.

	result := snapshot run result.

	"Here we ensure that the generated result has the night number of changes"
	self assert: baseEntitiesToMatch size equals: (result entityChanges reject: [ :change | change isAddition ]) size. "We should have a change that is not an addition for all entities of the base model."
	self assert: targetEntitiesToMatch size equals: (result entityChanges reject: [ :change | change isRemoval ]) size "We should have a change that is not a removal for all entities of the target model."
]

{ #category : 'running' }
FamixDiffTest >> setUp [

	super setUp.
	snapshot := FXDiff new
		            considerComments;
		            yourself
]

{ #category : 'tests' }
FamixDiffTest >> testAddedEntities [

	| addition |
	self createTestDiffForAdditionsAndRemovalsEdgeCases.
	addition := result additions.

	self assert: (self changes: addition ofType: FamixStPackage) size equals: 1.
	self assert: (self changes: addition ofType: FamixStPackage) first entity name equals: self packageName3.

	self assert: (self changes: addition ofType: FamixStClass ) size equals: 1.
	self assert: (self changes: addition ofType: FamixStClass ) first entity name equals: #C3.

	self assert: (self changes: addition ofType: FamixStMethod ) size equals: 1.
	self assert: (self changes: addition ofType: FamixStMethod ) first entity name equals: #m5.

	self assert: (self changes: addition ofType: FamixStLocalVariable ) size equals: 1.
	self assert: (self changes: addition ofType: FamixStLocalVariable ) first entity name equals: #temp3
]

{ #category : 'tests' }
FamixDiffTest >> testDiffAssociations [
	snapshot
		baseModel: (self createModelWith: #(#'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2'));
		targetModel: (self createModelWith: #(#'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2')).
	self runDiff.

	self assert: result associationChanges size equals: 6.
	self assert: (result associationChanges select: [ :c | c isAddition ]) size equals: 2.
	self assert: (result associationChanges select: [ :c | c isRemoval ]) size equals: 4
]

{ #category : 'tests' }
FamixDiffTest >> testDiffEntitiesAddP1 [

	snapshot baseModel: MooseModel new.
	snapshot targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	self runDiff.
	self assert: result entityChanges size equals: 9.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 9 "Smalltalk P1 A2 B2 + stubs: ProtoObject Object Kernel + 2 comments"
]

{ #category : 'tests' }
FamixDiffTest >> testDiffEntitiesDelP1 [

	snapshot baseModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	snapshot targetModel: MooseModel new.
	self runDiff.

	self assert: result entityChanges size equals: 9.
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 9 "Smalltalk P1 A2 B2 + stubs: ProtoObject Object Kernel + 2 comments"
]

{ #category : 'tests' }
FamixDiffTest >> testDiffEntitiesMatchP1 [

	snapshot baseModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	snapshot targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' )).
	self runDiff.

	self assert: result entityChanges size equals: 9.
	self assert: (result entityChanges select: [ :e | e isMatch ]) asSet size equals: 9
]

{ #category : 'tests' }
FamixDiffTest >> testDiffEntitiesP1P2P3 [

	snapshot baseModel: (self createModelWith: #( #'Famix-Diff-TestResource-P2' #'Famix-Diff-TestResource-P3' )).
	snapshot targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' )).
	self runDiff.
	self assert: result entityChanges size equals: 44.
	self assert: (result entityChanges select: [ :e | e isAddition ]) size equals: 3. "P2 A2diff B2diff"
	self assert: (result entityChanges select: [ :e | e isRemoval ]) size equals: 8. "P4 A4diff A4diff.att1 A4diff.b3() B4diff + annotations + 1 comment"

	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStLocalVariable ] ]) size equals: 12.
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStAttribute ] ]) size equals: 4. "A3.att1 A3.att2 B3.att1 B3.att2"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStMethod ] ]) size equals: 4. "A3.b2 A3.c3 B3.c3"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStClass ] ]) size equals: 5. "A3 B3 C3 Object ProtoObject"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStPackage ] ]) size equals: 2. "P3 Kernel"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStNamespace ] ]) size equals: 1. "Smalltalk"
	self assert: (result entityChanges select: [ :e | e isMatch and: [ e baseEntity isKindOf: FamixStComment ] ]) size equals: 5
]

{ #category : 'tests-run-entities' }
FamixDiffTest >> testMakeChangeWith [

	| entity change |
	entity := FamixStClass new
		          name: 'A';
		          yourself.
	change := FamixAddChange entity: entity.

	self assert: change class equals: FamixAddChange.
	self assert: change entity equals: entity
]

{ #category : 'tests-run-entities' }
FamixDiffTest >> testMakeChangeWithWith [

	| entityA change entityB |
	entityA := FamixStClass new
		           name: 'A';
		           yourself.
	entityB := FamixStClass new
		           name: 'B';
		           yourself.
	change := FamixRenameChange base: entityA target: entityB.

	self assert: change class equals: FamixRenameChange.
	self assert: change baseEntity equals: entityA.
	self assert: change targetEntity equals: entityB
]

{ #category : 'tests-run-entities' }
FamixDiffTest >> testMatched [

	| entity |
	entity := FamixStNamedEntity new.

	self deny: (snapshot resolver matched: entity).

	snapshot resolver changes at: entity put: FamixMoveChange new.

	self assert: (snapshot resolver matched: entity)
]

{ #category : 'tests' }
FamixDiffTest >> testMovedEntities [

	| moves |
	self createTestDiffForAdditionsAndRemovalsEdgeCases.
	moves := result moves.

	self assertEmpty: (self changes: moves ofType: FamixStPackage).
	self assertEmpty: (self changes: moves ofType: FamixStClass).
	self assert: (self changes: moves ofType: FamixStMethod) size equals: 2.
	self assertEmpty: (self changes: moves ofType: FamixStLocalVariable)
]

{ #category : 'tests' }
FamixDiffTest >> testRemovedEntities [

	| removals |
	self createTestDiffForAdditionsAndRemovalsEdgeCases.
	removals := result removals.

	self assert: (self changes: removals ofType: FamixStPackage) size equals: 1.
	self assert: (self changes: removals ofType: FamixStPackage) first entity name equals: self packageName1.

	self assert: (self changes: removals ofType: FamixStClass) size equals: 1.
	self assert: (self changes: removals ofType: FamixStClass) first entity name equals: #C1.

	self assert: (self changes: removals ofType: FamixStMethod) size equals: 1.
	self assert: (self changes: removals ofType: FamixStMethod) first entity name equals: #m1.

	self assertEmpty: (removals select: [ :change | change baseEntity isKindOf: FamixStLocalVariable ])
]

{ #category : 'tests' }
FamixDiffTest >> testWithTags [

	| baseModel |
	baseModel := self createModelWith: #( #'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2' ).
	(baseModel createTagNamed: 'Test') tagEntity: baseModel allModelClasses anyOne.
	snapshot
		baseModel: baseModel;
		targetModel: (self createModelWith: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' )).

	self shouldnt: [ self runDiff ] raise: Error
]
