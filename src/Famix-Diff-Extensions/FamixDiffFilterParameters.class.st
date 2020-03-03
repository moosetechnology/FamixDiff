"
Parameters for filtering from a list of famix changes.

Instance Variables
	changes:		<Object>
	metrics:		<Object>
	types:		<Object>

changes
	- xxxxx

metrics
	- xxxxx

types
	- xxxxx

"
Class {
	#name : #FamixDiffFilterParameters,
	#superclass : #Object,
	#instVars : [
		'changes',
		'types',
		'metrics'
	],
	#category : 'Famix-Diff-Extensions'
}

{ #category : #mapping }
FamixDiffFilterParameters >> changeClassesFrom: aCollectionOfDisplayNames [
	^ aCollectionOfDisplayNames collect: [:aChangName | FamixChange allSubclasses detect: [:aClass | aChangName = aClass displayName] ifNone: [ nil ]]
]

{ #category : #accessing }
FamixDiffFilterParameters >> changes [
	^ self changeClassesFrom: changes
]

{ #category : #accessing }
FamixDiffFilterParameters >> changes: aCollectionOfChanges [
	changes := aCollectionOfChanges
]

{ #category : #accessing }
FamixDiffFilterParameters >> metrics [
	^ metrics ifNil: [ #() ]
]

{ #category : #accessing }
FamixDiffFilterParameters >> metrics: aCollectionOfSelectors [
	metrics := aCollectionOfSelectors
]

{ #category : #mapping }
FamixDiffFilterParameters >> typeClassesFrom: aCollectionOfDisplayNames [
	^ aCollectionOfDisplayNames
		collect: [ :aDisplayName | FAMIXEntity allSubclasses detect: [ :aClass | aDisplayName = aClass displayName ] ifNone: [ nil ] ]
]

{ #category : #accessing }
FamixDiffFilterParameters >> types [
	^ self typeClassesFrom: types
]

{ #category : #accessing }
FamixDiffFilterParameters >> types: aCollectionOftypes [
	types := aCollectionOftypes
]
