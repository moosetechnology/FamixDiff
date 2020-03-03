running
setUp
	| importer |
	importer := self pharoImporter.
	importer
		model: MooseModel new;
		addFromPackagesNamed: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3');
		run.
	baseModel := importer model.
	baseModel name: 'base'.
	importer
		model: MooseModel new;
		addFromPackagesNamed: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3');
		run.
	targetModel := importer model.
	targetModel name: 'target'.
	changesComputation := FamixDiffChangesComputation new initializeDiffwith: baseModel and: targetModel.  