running
runOnBaseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer diffTransformers: aColOfDiffTransformers
	^ (self
		baseModel: aBaseModel
		targetModel: targetModel
		diffComputer: aDiffComputer
		diffTransformers: aColOfDiffTransformers) run