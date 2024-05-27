Class {
	#name : #AbstractFamixDiffWithModelTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'snapshot',
		'testChanges',
		'resolver'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChange: changeClass with: entity [

	testChanges at: entity put: (changeClass entity: entity)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChange: changeClass with: baseEntity and: targetEntity [

	| change |
	change := changeClass base: baseEntity target: targetEntity.
	testChanges at: baseEntity put: change.
	testChanges at: targetEntity put: change
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> setUp [

	| model1 model2 |
	super setUp.
	model1 := self importModelNamed: 'base' fromPackages: #( #'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2' ).
	model2 := self importModelNamed: 'target' fromPackages: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' ).
	snapshot := FXDiff baseModel: model1 targetModel: model2.
	testChanges := Dictionary new.
	resolver := FamixDiffResolver new.
	resolver
		changesDico: testChanges;
		orchestrator: snapshot.
	self createChange: FamixUnchangedChange with: (snapshot baseModel entityNamed: 'Smalltalk') and: (snapshot targetModel entityNamed: 'Smalltalk')
]
