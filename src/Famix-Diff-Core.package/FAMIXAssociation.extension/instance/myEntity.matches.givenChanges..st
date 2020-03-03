*Famix-Diff-Core
myEntity: myEntity matches: otherEntity givenChanges: entityChanges
	"two entities in an association matche if:
		both are stubs and their full names match
		or neither is stub and they are known to match (in entitentityChanges)"

	myEntity ifNil: [ ^ otherEntity isNil ].
	otherEntity ifNil: [ ^ false ].
	(myEntity isStub and: [ otherEntity isStub ])
		ifTrue: [ ^ myEntity mooseName = otherEntity mooseName ].
	"	otherEntity isStub ifTrue: [^ false]."	"There should not be a stub check..."
	^ (entityChanges at: myEntity) = (entityChanges at: otherEntity)