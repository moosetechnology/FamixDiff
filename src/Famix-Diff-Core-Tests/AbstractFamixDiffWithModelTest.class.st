Class {
	#name : #AbstractFamixDiffWithModelTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'diff'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #accessing }
AbstractFamixDiffWithModelTest >> baseEntityNamed: aString [

	^ diff baseModel entityNamed: aString
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChange: changeClass with: entity [

	self resolver changesDico at: entity put: (changeClass entity: entity)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChange: changeClass with: baseEntity and: targetEntity [

	| change |
	change := changeClass base: baseEntity target: targetEntity.
	self resolver changesDico
		at: baseEntity put: change;
		at: targetEntity put: change
]

{ #category : #accessing }
AbstractFamixDiffWithModelTest >> resolver [

	^ diff resolver
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> setUp [

	| model1 model2 |
	super setUp.
	model1 := self importModelNamed: 'base' fromPackages: #( #'Famix-Diff-TestResource-P3' #'Famix-Diff-TestResource-P2' ).
	model2 := self importModelNamed: 'target' fromPackages: #( #'Famix-Diff-TestResource-P1' #'Famix-Diff-TestResource-P2' ).
	diff := FXDiff baseModel: model1 targetModel: model2.
	self createChange: FamixUnchangedChange with: (self baseEntityNamed: 'Smalltalk') and: (self targetEntityNamed: 'Smalltalk')
]

{ #category : #accessing }
AbstractFamixDiffWithModelTest >> targetEntityNamed: aString [

	^ diff targetModel entityNamed: aString
]
