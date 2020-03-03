Class {
	#name : #DiffComputationTests,
	#superclass : #TestCase,
	#instVars : [
		'baseModel',
		'targetModel',
		'changesComputation'
	],
	#category : 'Famix-Diff-Extensions-Tests'
}

{ #category : #init }
DiffComputationTests >> pharoImporter [
	| importer |
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer candidateClass: CandidateListOperator.
	importer importerClass: SmalltalkImporter.
	^ importer
]

{ #category : #running }
DiffComputationTests >> setUp [
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
]

{ #category : #running }
DiffComputationTests >> testChangeIndicators [
	self assert: (changesComputation indicatorsFor: changesComputation changes anyOne) isEmpty not
]

{ #category : #running }
DiffComputationTests >> testChangeTypes [
	self assert: changesComputation changeTypes anyOne equals: FamixAddChange displayName
]

{ #category : #running }
DiffComputationTests >> testFilterChanges [
	| changes filterParams|
	filterParams := FamixDiffFilterParameters new changes: #('Add'); types: #('Package'); metrics: {'Name Length' -> #(30 40)} asDictionary; yourself.
	changes := changesComputation filterChangesWith: filterParams.
	self assert: changes size equals: 1.
	self assert: changesComputation typesFilter selection size equals: 1.
	self assert: changesComputation typesFilter selection first equals: FAMIXPackage.
	self assert: changesComputation changesFilter selection size equals: 1.
	self assert: changesComputation changesFilter selection first equals: FamixAddChange.
	self assert: changesComputation metricsFilter selection size equals: 1.
	self assert: changesComputation metricsFilter selection keys first equals: 'Name Length'.
	self assert: changesComputation metricsFilter selection values first size equals: 2.
	
]

{ #category : #running }
DiffComputationTests >> testNumberOfChanges [
	self assert: changesComputation changes size equals: 3.
	self assert: changesComputation displayedChanges size equals: 3.
	self deny: changesComputation famixDiff isNil
]

{ #category : #running }
DiffComputationTests >> testSortChanges [
	| changes |
	changes := changesComputation sortChangesWith: {'Name LENGTH'.'Ascending'}.
	self assert: changes size equals: 3.
	self assert: changes last entity mooseName equals: #'Moose-TestResources-ModelDiff-P2'.
	changesComputation metricsSorter selection: {'Name LENGTH'.'Descending'}.
	changes := changesComputation metricsSorter computeResult.
	self assert: (changes last entity mooseName beginsWith:  'Smalltalk').
	
	
]

{ #category : #running }
DiffComputationTests >> testSorterMetricName [
	changesComputation metricsSorter selection: {'Name Length'. 'Ascending' }.
	self assert: changesComputation metricsSorter sortSelector equals: #nameLength.
	changesComputation metricsSorter selection: {'Number Of attributes'. 'Ascending' }.
	self assert: changesComputation metricsSorter sortSelector equals: #numberOfAttributes.
]

{ #category : #running }
DiffComputationTests >> testTypesChanged [
	self assert: changesComputation typesChanged size equals: 2.
	self assert: (changesComputation typesChanged includes: FAMIXPackage displayName).
	self assert: (changesComputation typesChanged includes: FAMIXClass displayName)
]

{ #category : #running }
DiffComputationTests >> testTypesChangedAndMetics [
	self assert: (changesComputation metricsFilter selectorForMetricName: ('Name length'))  equals: #nameLength.
]

{ #category : #running }
DiffComputationTests >> testTypesChangedCustomMetrics [
	| metricsSelected |
	metricsSelected := changesComputation changeMetricsFor: #('Class').
	self assert: metricsSelected size equals: 1.
	self assert: (metricsSelected keys includes: #Class).
	self assert: (metricsSelected at: #Class) size equals: 8.
]
