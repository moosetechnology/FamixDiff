Class {
	#name : #DiffBrowserMetricsSorterTests,
	#superclass : #FamixDiffBrowserTests,
	#instVars : [
		'sorter'
	],
	#category : 'Famix-Diff-Browser-Tests'
}

{ #category : #running }
DiffBrowserMetricsSorterTests >> setUp [
	super setUp.
	self transmitBase.
	self transmitTarget.
	changesComputation := diffBrowser changesComputation.
]

{ #category : #accessing }
DiffBrowserMetricsSorterTests >> sorter [
	^ sorter ifNil: [sorter := FamixDiffMetricsSorter new changes: diffBrowser displayedChanges; selection: {#nameLength.'Descending'}; yourself]
]

{ #category : #tests }
DiffBrowserMetricsSorterTests >> testSorting [
	self sorter selection: {'Number of attributes'.'Descending'}.
	(diffBrowser displayedChanges: self sorter computeResult).
	self assert: diffBrowser displayedChanges size equals: 2.
	self assert: (diffBrowser displayedChanges first entity mooseName beginsWith: 'Smalltalk').
]

{ #category : #tests }
DiffBrowserMetricsSorterTests >> testSortingAndSelectedMetrics [
	| sorterWizard |
	sorterWizard := FamixDiffSorterWizard new browser: diffBrowser; yourself.
	self assert: (sorterWizard changeMetrics) size equals: 8.
	sorterWizard filterChangesWith:  { #selectedChanges -> {#Add->true}. #selectedTypes -> {#Package->true. #Behaviour->false}. #'metricName Length'->true. #'maxName Length'->'40'. #'minName Length'->'30'} asDictionary.
	self assert: (sorterWizard changeMetrics ) size equals: 1.
]

{ #category : #tests }
DiffBrowserMetricsSorterTests >> testSortingParams [
	diffBrowser displayedChanges: (diffBrowser changesComputation metricsSorter changes: diffBrowser displayedChanges; selection: {'Name LEngth'.'Ascending'}; computeResult).
	self assert: diffBrowser displayedChanges last entity mooseName equals: #'Moose-TestResources-ModelDiff-P2'
]

{ #category : #tests }
DiffBrowserMetricsSorterTests >> testSortingWithWizardFormat [
	| sorterWizard |
	sorterWizard := FamixDiffSorterWizard new browser: diffBrowser; yourself.
	sorterWizard sortChangesWith: {#sortDirection->'Descending'. #sorterMetric-> 'Name Length'} asDictionary.
	self assert: (diffBrowser displayedChanges last entity mooseName beginsWith: 'Smalltalk').
]
