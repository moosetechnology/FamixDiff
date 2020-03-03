Class {
	#name : #DiffFilterParametersTests,
	#superclass : #TestCase,
	#instVars : [
		'filterParams'
	],
	#category : 'Famix-Diff-Extensions-Tests'
}

{ #category : #'as yet unclassified' }
DiffFilterParametersTests >> setUp [
	filterParams := FamixDiffFilterParameters new.
]

{ #category : #'as yet unclassified' }
DiffFilterParametersTests >> testAllSubClasses [
	FamixChange allSubclasses do: [:aClass | self deny: (filterParams changeClassesFrom: {aClass displayName}) isNil]
]

{ #category : #'as yet unclassified' }
DiffFilterParametersTests >> testChangesMapping [
	self assert: (filterParams changeClassesFrom: #('Add')) first equals: FamixAddChange
]

{ #category : #'as yet unclassified' }
DiffFilterParametersTests >> testTypesMapping [
	self assert: (filterParams typeClassesFrom: #('Class')) first equals: FAMIXClass
]
