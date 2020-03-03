running
runOnBaseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer diffTransformers: aColOfDiffTransformers args: aDicoOfArgs
	^ (self
		baseModel: aBaseModel
		targetModel: targetModel
		diffComputer: aDiffComputer
		diffTransformers: aColOfDiffTransformers)
		args: aDicoOfArgs;
		run