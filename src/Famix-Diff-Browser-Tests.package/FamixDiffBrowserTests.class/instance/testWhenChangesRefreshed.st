tests
testWhenChangesRefreshed
	self transmitBase.
	self transmitTarget.
	self assert: diffBrowser displayedChanges size equals: 3.
	diffBrowser sorterWizard browser: diffBrowser; filterChangesWith:  { #selectedChanges -> {#Add->true}. #selectedTypes -> {#Package->false. #Class->true}} asDictionary.
	self assert: diffBrowser displayedChanges size equals: 2.
	diffBrowser sorterWizard browser: diffBrowser; filterChangesWith:  { #selectedChanges -> {#Add->true}. #selectedTypes -> {#Package->true. #Class->true}} asDictionary.
	self assert: diffBrowser displayedChanges size equals: 3.
	
	