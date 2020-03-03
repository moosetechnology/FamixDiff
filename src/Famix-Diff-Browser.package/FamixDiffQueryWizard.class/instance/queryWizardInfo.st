accessing
queryWizardInfo
	^ queryWizardInfo ifNil: [ queryWizardInfo := FamixDiffQueryWizardInfo new typesSelected: self changesComputation typesChanged ]. 	