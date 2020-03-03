tests
testBrowserActions
	| actions |
	self transmitBase.
	self transmitTarget.
	actions := (browserWindow model paneNamed: #changesList) presentations first dynamicActions.
	self assert: actions size equals: 2.
	actions do: [ :anAction | 
		|process |
		process := [self shouldnt: anAction action value raise: Error] fork.
		(Delay forMilliseconds: 200) wait.
		PluggableDialogWindow allInstances do: [:each | each delete].
		PluggableDialogWindow allInstances last delete.
		process terminate.
				
		]