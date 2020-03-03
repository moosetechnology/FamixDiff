instance creation
baseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer
	^ self
		baseModel: aBaseModel
		targetModel: targetModel
		diffComputer: aDiffComputer
		diffTransformers: nil