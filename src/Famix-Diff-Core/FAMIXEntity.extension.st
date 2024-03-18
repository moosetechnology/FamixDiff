Extension { #name : #FAMIXEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> comeBeforeEntity: aFamixEntity [
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
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> comeBeforeEntityOrHasSameName: aFamixEntity [
	^ (self comeBeforeEntity: aFamixEntity ) or: [ self mooseName =  aFamixEntity mooseName]
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> comeBeforeTheIndependentEntity: aFamixEntity [
	"self and aFamixEntity are not in the same containment tree"

	^ (self typePriorityOf: self getFamixClass) < (self typePriorityOf: aFamixEntity getFamixClass)
		or: [ (self eq: aFamixEntity) and: [ self mooseName < aFamixEntity mooseName ] ]
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> eq: aFamixEntity [
	^ self getFamixClass = aFamixEntity getFamixClass
		
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> getFamixClass [

	^ self class
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> isParameterizableClass [
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> isScopingEntity [
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> parentContainer [
	^ self belongsTo
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity class >> prefixLength [
	^'FAMIX' size
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> shouldBeConsideredForDiff [
	^ false
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> typeOrderPriority [
	^ { FAMIXNamespace . FAMIXPackage . FAMIXClass . FAMIXParameterizableClass . FAMIXPrimitiveType . FAMIXParameterType . FAMIXAnnotationType . FAMIXEnum . FAMIXType . FAMIXParameterizedType . FAMIXMethod . #FAMIXInnerClass .#FAMIXTypeInnerMethod. #FAMIXAnonymousClass . #FAMIXMethodInAnonymousClass . FAMIXAttribute . FAMIXEnumValue . FAMIXAnnotationTypeAttribute . FAMIXParameter. FAMIXLocalVariable . FAMIXImplicitVariable .  FAMIXAccess . FAMIXInvocation . FAMIXReference . FAMIXInheritance  }
]

{ #category : #'*Famix-Diff-Core' }
FAMIXEntity >> typePriorityOf: aFamixClass [
	^ self typeOrderPriority indexOf: aFamixClass 
]
