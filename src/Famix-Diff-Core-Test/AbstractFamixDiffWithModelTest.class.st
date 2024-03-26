Class {
	#name : #AbstractFamixDiffWithModelTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'snapshot',
		'testChanges',
		'resolver'
	],
	#category : #'Famix-Diff-Core-Test'
}

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChg: chgClass with: entity [

	testChanges at: entity put: (chgClass entity: entity)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChg: chgClass with: baseEntity and: targetEntity [

	| change |
	change := chgClass base: baseEntity target: targetEntity.
	testChanges at: baseEntity put: change.
	testChanges at: targetEntity put: change
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> setUp [

	| model1 model2 |
	model1 := self importModelNamed: 'base' fromPackages: #( #'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3' ).
	model2 := self importModelNamed: 'target' fromPackages: #( #'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3' ).
	snapshot := FXDiff baseModel: model1 targetModel: model2.
	testChanges := Dictionary new.
	resolver := FamixDiffResolver new.
	resolver
		changesDico: testChanges;
		orchestrator: snapshot.
	self createChg: FamixUnchangedChange with: (snapshot baseModel entityNamed: 'Smalltalk') and: (snapshot targetModel entityNamed: 'Smalltalk')
]
