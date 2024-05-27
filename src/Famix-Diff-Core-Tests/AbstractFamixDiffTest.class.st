Class {
	#name : #AbstractFamixDiffTest,
	#superclass : #TestCase,
	#traits : 'TMooseSmalltalkModelImporterForTests',
	#classTraits : 'TMooseSmalltalkModelImporterForTests classTrait',
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
AbstractFamixDiffTest >> importModelNamed: name fromPackages: packages [
	| importer model |
	model := FamixStModel new.
	model name: name.
	importer := FamixStPharoImporterTask new
		model: model;
		addFromPackagesNamed: packages;
		yourself.
	importer importingContext mergeClassAndMetaclass.
	importer basicRun.
	^ model
]
