*Famix-Diff-Core
comeBeforeEntity: aFamixEntity
	| parents myParents |
	aFamixEntity isAssociation
		ifTrue: [ ^ self comeBeforeTheIndependentEntity: aFamixEntity ].
	parents := aFamixEntity deepCollect: [ :element | element ifNotNil: [ element parentContainer ] ].
	myParents := self deepCollect: [ :element | element ifNotNil: [ element parentContainer ] ].
	(parents includes: self)
		ifTrue: [ ^ true ].
	(myParents includes: aFamixEntity)
		ifTrue: [ ^ false ].
	^ self comeBeforeTheIndependentEntity: aFamixEntity