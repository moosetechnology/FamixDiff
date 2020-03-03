actions
defaultActions
	^{GLMGenericAction new title: 'Filter Changes'; action: [ self filterWizard browser: self; filterSelectionChooser ]; icon: MooseIcons famixFunction.
	GLMGenericAction new title: 'Sort Changes'; action: [ self sorterWizard browser: self; sortChooser]; icon: MooseIcons mooseList
	   }