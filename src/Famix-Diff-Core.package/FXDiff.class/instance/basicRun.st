private
basicRun
	diffComputer diff.
	diffTransformers ifNotNil: [ self diffTransformers do: [ :aPostOperationClass | aPostOperationClass run ] ]