Class {
	#name : #AbstractFamixDiffTest,
	#superclass : #TestCase,
	#traits : 'TMooseSmalltalkModelImporterForTests',
	#classTraits : 'TMooseSmalltalkModelImporterForTests classTrait',
	#instVars : [
		'model'
	],
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #accessing }
AbstractFamixDiffTest >> model [
	^ model
]

{ #category : #accessing }
AbstractFamixDiffTest >> model: anObject [
	model := anObject
]
