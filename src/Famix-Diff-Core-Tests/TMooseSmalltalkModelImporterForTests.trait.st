Trait {
	#name : 'TMooseSmalltalkModelImporterForTests',
	#category : 'Famix-Diff-Core-Tests',
	#package : 'Famix-Diff-Core-Tests'
}

{ #category : 'running' }
TMooseSmalltalkModelImporterForTests >> importModelNamed: name fromPackages: packages [
	| model |
	model := FamixStModel new.
	model name: name.
	FamixStPharoImporterTask new
		model: model;
		addFromPackagesNamed: packages;
		basicRun.
	^ model
]
