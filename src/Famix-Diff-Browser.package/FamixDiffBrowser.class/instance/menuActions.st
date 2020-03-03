actions
menuActions
	^ self displayedChanges isEmpty
		ifTrue: [ #() ]
		ifFalse: [ self defaultActions , self actions ]