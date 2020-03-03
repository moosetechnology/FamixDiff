instance creation
baseModel: aBaseModel targetModel: targetModel diffComputer: aDiffComputer diffTransformers: aColOfDiffTransformers
	^ self new
		baseModel: aBaseModel;
		targetModel: targetModel;
		diffComputer: aDiffComputer;
		diffTransformers: aColOfDiffTransformers;
		yourself