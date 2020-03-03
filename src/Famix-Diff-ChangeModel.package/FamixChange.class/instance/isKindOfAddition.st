testing
isKindOfAddition
	^ self isAddition
		or: [ self isMove or: [ self isRename or: [ self isBody ] ] ]