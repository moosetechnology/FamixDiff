Class {
	#name : #AbstractFamixDiffWithModelTest,
	#superclass : #AbstractFamixDiffTest,
	#instVars : [
		'diff'
	],
	#category : #'Famix-Diff-Core-Tests'
}

{ #category : #running }
AbstractFamixDiffWithModelTest >> assertIdentityMatch: entity1 to: entity2 [

	self assert: (entity1 identityMatch: entity2 resolver: self resolver)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> assertMoveMatch: entity1 to: entity2 [

	self assert: (entity1 moveMatch: entity2 resolver: self resolver)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> assertRenameMatch: entity1 to: entity2 [

	self assert: (entity1 renameMatch: entity2 resolver: self resolver)
]

{ #category : #accessing }
AbstractFamixDiffWithModelTest >> baseEntityNamed: aString [

	^ diff baseModel entityNamed: aString
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChange: changeClass with: entity [

	| change |
	change := changeClass entity: entity.
	self resolver changes at: entity put: change.
	diff result add: change
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> createChange: changeClass with: baseEntity and: targetEntity [

	| change |
	change := changeClass base: baseEntity target: targetEntity.
	self resolver changes
		at: baseEntity put: change;
		at: targetEntity put: change.
	diff result add: change
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> denyIdentityMatch: entity1 to: entity2 [

	self deny: (entity1 identityMatch: entity2 resolver: self resolver)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> denyMoveMatch: entity1 to: entity2 [

	self deny: (entity1 moveMatch: entity2 resolver: self resolver)
]

{ #category : #running }
AbstractFamixDiffWithModelTest >> denyRenameMatch: entity1 to: entity2 [

	self deny: (entity1 renameMatch: entity2 resolver: self resolver)
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

{ #category : #running }
AbstractFamixDiffWithModelTest >> tearDown [

	diff resolver removeFamixDiffCaches.
	super tearDown
]
