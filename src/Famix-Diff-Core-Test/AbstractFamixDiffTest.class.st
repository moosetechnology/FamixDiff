Class {
	#name : #AbstractFamixDiffTest,
	#superclass : #TestCase,
	#traits : 'TMooseSmalltalkModelImporterForTests',
	#classTraits : 'TMooseSmalltalkModelImporterForTests classTrait',
	#instVars : [
		'model'
	],
	#category : #'Famix-Diff-Core-Test'
}

{ #category : #running }
AbstractFamixDiffTest >> importModelNamed: name fromPackages: packages [
	| importer |
	model := FAMIXModel new.
	model name: name.
	importer := MoosePharoImporterTask new
		model: model;
		addFromPackagesNamed: packages;
		yourself.
	importer importingContext mergeClassAndMetaclass.
	importer basicRun.
	^ model
]

{ #category : #accessing }
AbstractFamixDiffTest >> model [
	^ model
]

{ #category : #accessing }
AbstractFamixDiffTest >> model: anObject [
	model := anObject
]
