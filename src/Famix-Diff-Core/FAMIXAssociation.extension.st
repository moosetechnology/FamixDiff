Extension { #name : #FAMIXAssociation }

{ #category : #'*Famix-Diff-Core' }
FAMIXAssociation >> comeBeforeEntity: aFamixEntity [
	^ (self eq: aFamixEntity)
		ifTrue: [ self mooseName < aFamixEntity mooseName ]
		ifFalse: [ (self typePriorityOf: self getFamixClass) < (self typePriorityOf: aFamixEntity getFamixClass) ]
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAssociation >> matches: otherAssoc givenChanges: entityChanges [

	self class = otherAssoc class ifFalse: [ ^ false ].

	"this test could be simplified because the 'from' cannot be a Stub in any association"
	(self myEntity: self source matches: otherAssoc source givenChanges: entityChanges) ifFalse: [ ^ false ].
	^ self myEntity: self target matches: otherAssoc target givenChanges: entityChanges
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAssociation >> mooseNameOn: t1 [

	self displayStringOn: t1
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAssociation >> myEntity: myEntity matches: otherEntity givenChanges: entityChanges [
	"two entities in an association matche if:
		both are stubs and their full names match
		or neither is stub and they are known to match (in entitentityChanges)"

	myEntity ifNil: [ ^ otherEntity isNil ].
	otherEntity ifNil: [ ^ false ].
	(myEntity isStub and: [ otherEntity isStub ])
		ifTrue: [ ^ myEntity mooseName = otherEntity mooseName ].
	"	otherEntity isStub ifTrue: [^ false]."	"There should not be a stub check..."
	^ (entityChanges at: myEntity) = (entityChanges at: otherEntity)
]

{ #category : #'*Famix-Diff-Core' }
FAMIXAssociation >> parentContainer [ 
	^ nil
]
