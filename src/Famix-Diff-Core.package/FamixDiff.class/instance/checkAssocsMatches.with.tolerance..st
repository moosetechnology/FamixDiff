run-associations
checkAssocsMatches: baseAssocs with: targetAssocs tolerance: anObject
	baseAssocs
		do: [ :baseAss | 
			targetAssocs
				detect: [ :targetAss | targetAss matches: baseAss givenChanges: self changesDico ]
				ifOne: [ :found | targetAssocs remove: found ]
				ifNone: [ 
					self assocChanges
						add:
							(FamixRemovalChange new
								entity: baseAss;
								yourself) ]	"not creating FAMIXMatchChange for associations" ].
	self addAssociations: targetAssocs