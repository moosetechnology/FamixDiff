matching-entities
matches: matchblock from: baseEntities to: targetEntities ifMatch: ifMatchBlock progressMessage: aString
	"Find matches defined by matchblock (returns true -> match) between baseEntities and targetEntities.
	 matchblock takes 2 parameters: first is baseEntity, second is targetEntity being compared.
	
	 When a match is found, ifMatchBlock is evaluated with the base entity as first parameter and the target entity as second parameter.
	 The progress message is displayed by the UI during the computation.
	
	 This algorithm essentially takes each entity from baseEntities and try to match them with an entity in targetEntity list."
	| matchFound |
	matchFound := false.
	baseEntities
		do: [ :eBase | 
			targetEntities
				detect: [ :eTarget | matchblock value: eBase value: eTarget ]
				ifOne: [ :eTarget |
					ifMatchBlock value: eBase value: eTarget.
					matchFound := true ] ]
		displayingProgress: aString.
	^ matchFound