Class {
	#name : #FamixDiffWithFilter,
	#superclass : #FamixDiff,
	#instVars : [
		'pckgFilter'
	],
	#category : 'Famix-Diff-Core'
}

{ #category : #'run-entities' }
FamixDiffWithFilter >> inFilteredPackage: e [
	e ifNil: [ ^ false ].
	e isScopingEntity
		ifFalse: [ e parentPackage
				ifNil: [ ^ self inFilteredPackage: e belongsTo ]
				ifNotNil: [ ^ self inFilteredPackage: e parentPackage ] ].
	pckgFilter isString
		ifFalse: [ ^ pckgFilter anySatisfy: [ :f | e mooseName beginsWith: f ] ].
	pckgFilter = ''
		ifFalse: [ ^ e mooseName beginsWith: pckgFilter ].
	^ true
]

{ #category : #initialization }
FamixDiffWithFilter >> initialize [
	super initialize.
	pckgFilter := ''

]

{ #category : #accessing }
FamixDiffWithFilter >> pckgFilter [
	
	^ pckgFilter
]

{ #category : #accessing }
FamixDiffWithFilter >> pckgFilter: filter [
	filter ifNil: [ pckgFilter := '' ] ifNotNil: [pckgFilter := filter]
]
