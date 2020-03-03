running
createChg: chgClass with: entity 

	testChanges at: entity put: (chgClass new entity: entity ; yourself).
