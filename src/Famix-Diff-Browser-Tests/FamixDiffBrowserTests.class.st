Class {
	#name : #FamixDiffBrowserTests,
	#superclass : #TestCase,
	#instVars : [
		'browserWindow',
		'baseModel',
		'targetModel',
		'diffBrowser',
		'changesComputation'
	],
	#category : 'Famix-Diff-Browser-Tests'
}

{ #category : #accessing }
FamixDiffBrowserTests >> browserWindow [
	^browserWindow
]

{ #category : #accessing }
FamixDiffBrowserTests >> changes [
	^ (FXDiff runOnBaseModel: baseModel targetModel: targetModel) result allEntitiesImpactingChanges sorted: [ :a :b | a comeBeforeOrIsEquivalent: b ]
]

{ #category : #init }
FamixDiffBrowserTests >> pharoImporter [
	| importer |
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer candidateClass: CandidateListOperator.
	importer importerClass: SmalltalkImporter.
	^ importer
]

{ #category : #running }
FamixDiffBrowserTests >> setUp [
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
	diffBrowser := FamixDiffBrowser new.
	browserWindow := diffBrowser modelSelector: #yourself; openOn: {baseModel. targetModel}
]

{ #category : #running }
FamixDiffBrowserTests >> tearDown [
	browserWindow delete.
]

{ #category : #tests }
FamixDiffBrowserTests >> testBrowserActions [
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
]

{ #category : #tests }
FamixDiffBrowserTests >> testBrowserOpening [
	self deny: browserWindow isNil.
]

{ #category : #tests }
FamixDiffBrowserTests >> testDisplayNameProtocol [
	FamixChange subclasses do: [:aClass | self assert: (aClass respondsTo: #displayName) ]
]

{ #category : #tests }
FamixDiffBrowserTests >> testDropDownLists [
	self assert: (browserWindow model paneNamed: #baseModel) presentations first displayValue size equals: 2.
	self assert: (browserWindow model paneNamed: #targetModel) presentations first displayValue size equals: 2.
	self assert: (browserWindow model paneNamed: #targetModel) presentations first displayValue first equals: baseModel.
	self assert: (browserWindow model paneNamed: #baseModel) presentations first displayValue second equals: targetModel.
]

{ #category : #tests }
FamixDiffBrowserTests >> testMetricsPane [
	self transmitBase.
	self transmitTarget.
	((browserWindow model paneNamed: #changesList) port: #selection) value: (self changes reject: #isForAssociation) last.
	self assert: (browserWindow model paneNamed: #metrics) presentations first displayValue size equals:9
]

{ #category : #tests }
FamixDiffBrowserTests >> testPanesSize [
	self assert: browserWindow model panes size equals: 4.
]

{ #category : #tests }
FamixDiffBrowserTests >> testTransmissionToChangeList [
	self transmitBase.
	self transmitTarget.
	self assert: (self browserWindow model paneNamed: #changesList) presentations first displayValue size equals: 3.
	self assert: ((self browserWindow model paneNamed: #changesList) port: #entity) value size equals: 3.
]

{ #category : #tests }
FamixDiffBrowserTests >> testWhenChangesRefreshed [
	self transmitBase.
	self transmitTarget.
	self assert: diffBrowser displayedChanges size equals: 3.
	diffBrowser sorterWizard browser: diffBrowser; filterChangesWith:  { #selectedChanges -> {#Add->true}. #selectedTypes -> {#Package->false. #Class->true}} asDictionary.
	self assert: diffBrowser displayedChanges size equals: 2.
	diffBrowser sorterWizard browser: diffBrowser; filterChangesWith:  { #selectedChanges -> {#Add->true}. #selectedTypes -> {#Package->true. #Class->true}} asDictionary.
	self assert: diffBrowser displayedChanges size equals: 3.
	
	
]

{ #category : #tests }
FamixDiffBrowserTests >> testWhenSameModel [
	self transmitBase.
	self transmitTarget.
	((browserWindow model paneNamed: #targetModel) port: #selection) value: baseModel.
	self assert: (browserWindow model paneNamed: #changesList) presentations first dynamicActions size equals: 0.
	
]

{ #category : #init }
FamixDiffBrowserTests >> transmitBase [
	((browserWindow model paneNamed: #baseModel) port:#selection) value: baseModel
]

{ #category : #init }
FamixDiffBrowserTests >> transmitTarget [
	((browserWindow model paneNamed: #targetModel) port:#selection) value: targetModel
]
