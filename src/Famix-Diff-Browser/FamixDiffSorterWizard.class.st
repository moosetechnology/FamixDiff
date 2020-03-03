"
Metrics sorter.

Instance Variables
	sorter:		<Object>

sorter
	- xxxxx

"
Class {
	#name : #FamixDiffSorterWizard,
	#superclass : #FamixDiffQueryWizard,
	#category : 'Famix-Diff-Browser'
}

{ #category : #metrics }
FamixDiffSorterWizard >> indicatorsFromChanges [
	^ self browser changesComputation changeMetricsForDisplayedChanges
]

{ #category : #sorting }
FamixDiffSorterWizard >> selectedOption [
	^ (self sorter sortMetric)
]

{ #category : #sorting }
FamixDiffSorterWizard >> sortChangesWith: aDictionaryOfSelections [
	 | sortedChanges |
sortedChanges := self browser changesComputation sortChangesWith: {aDictionaryOfSelections values first. aDictionaryOfSelections values second}.
	self browser displayedChanges: sortedChanges
]

{ #category : #sorting }
FamixDiffSorterWizard >> sortChooser [
	| wizardPane1 wizardControl |
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	wizardPane1 row: self sortDirection associatedTo: #sortDirection.
	wizardPane1 row: self sorterMetricChooser associatedTo: #sorterMetric.
	wizardControl addPane: wizardPane1.
	wizardControl atEndDo: [ :aDictionaryOfSelections | self sortChangesWith: aDictionaryOfSelections ].
	wizardControl open
]

{ #category : #sorting }
FamixDiffSorterWizard >> sortDirection [
	^ DropListPart new 	
			list: #('Ascending' 'Descending');
			inGroupboxNamed: 'Sort Direction';
			defaultValue: self sorter sortDirection;
			yourself.
]

{ #category : #sorting }
FamixDiffSorterWizard >> sorter [
	^ self browser changesComputation metricsSorter
]

{ #category : #sorting }
FamixDiffSorterWizard >> sorterMetricChooser [
	^ RadioButtonsPart new
			options: self changeMetrics asArray sorted;
			inGroupboxNamed: 'Select Metric to Sort';
			defaultValue: self selectedOption;
			yourself
	
]
