accessing
changes
	^ (FXDiff runOnBaseModel: baseModel targetModel: targetModel) result allEntitiesImpactingChanges sorted: [ :a :b | a comeBeforeOrIsEquivalent: b ]