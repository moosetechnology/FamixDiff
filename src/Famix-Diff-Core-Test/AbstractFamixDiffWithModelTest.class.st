Class {
	#name : #AbstractFamixDiffWithModelTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'snapshot',
		'testChanges'
	],
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChg: chgClass with: entity [ 

	testChanges at: entity put: (chgClass new entity: entity ; yourself).

]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChg: chgClass with: eBase and: eTarget [
	| tmpChg|
	tmpChg := chgClass new baseEntity: eBase ; targetEntity:  eTarget ; yourself.
	testChanges at: eBase put: tmpChg.
	testChanges at: eTarget put: tmpChg.

]

{ #category : #running }
AbstractFamixDiffWithModelTest >> setUp [
	| model1 model2 |
	model1 := self importModelNamed: 'base' fromPackages: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3').
	model2 := self importModelNamed: 'target' fromPackages: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3').
	snapshot := FXDiff baseModel: model1 targetModel: model2.
	testChanges := Dictionary new
]
