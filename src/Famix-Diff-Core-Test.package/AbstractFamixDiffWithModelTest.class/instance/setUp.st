running
setUp
	| model1 model2 |
	model1 := self importModelNamed: 'base' fromPackages: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3').
	model2 := self importModelNamed: 'target' fromPackages: #(#'Moose-TestResources-ModelDiff-P2' #'Moose-TestResources-ModelDiff-P3').
	snapshot := FXDiff baseModel: model1 targetModel: model2.
	testChanges := Dictionary new