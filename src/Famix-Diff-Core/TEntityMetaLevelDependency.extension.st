Extension { #name : #TEntityMetaLevelDependency }

{ #category : #'*Famix-Diff-Core' }
TEntityMetaLevelDependency >> compareParentsWith: otherEntity resolver: resolver [
	"I check that the parents of both entities are the same."

	<famixDiffIdentity>
	| baseParents targetParents |
	baseParents := self parents.
	targetParents := otherEntity parents.

	baseParents size = targetParents size ifFalse: [ ^ false ].

	baseParents do: [ :baseParent | 
		targetParents
			detect: [ :targetParent | "We delegate the comparison to the resolver because it's possible a parent is the same but got renamed. This should deal with this case." 
				resolver is: baseParent sameAs: targetParent ]
			ifNone: [ ^ false "A parent of the base entity does not have a matching parent so we escape." ] ].

	^ true
]

{ #category : #'*Famix-Diff-Core' }
TEntityMetaLevelDependency >> identityMatch: otherEntity resolver: aFamixDiffResolver [

	self class = otherEntity class ifFalse: [ ^ false ].

	"We consider that the entities are identical if all comparators declared for the entity with the following pragma are matching."
	(Pragma allNamed: #famixDiffIdentity from: self class to: ProtoObject) do: [ :pragma | 
		(self perform: pragma methodSelector withEnoughArguments: {  otherEntity . aFamixDiffResolver }) ifFalse: [ ^ false ] ].

	^ true
]
