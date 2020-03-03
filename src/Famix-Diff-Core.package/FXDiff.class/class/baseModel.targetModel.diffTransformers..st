instance creation
baseModel: aBaseModel targetModel: targetModel diffTransformers: aColOfDiffTransformers
	^ self new
		baseModel: aBaseModel;
		targetModel: targetModel;
		diffComputer: self defaultDiffComputer;
		diffTransformers: aColOfDiffTransformers;
		yourself