Class {
	#name : #DiffBrowserFilterTests,
	#superclass : #FamixDiffBrowserTests,
	#category : 'Famix-Diff-Browser-Tests'
}

{ #category : #running }
DiffBrowserFilterTests >> setUp [
	super setUp.
	self transmitBase.
	self transmitTarget.
	changesComputation := diffBrowser changesComputation.
]

{ #category : #tests }
DiffBrowserFilterTests >> testActionsWhenChangesEmpty [
	self assert: (browserWindow model paneNamed: #changesList) presentations first dynamicActions size equals: 2.
	changesComputation typesFilter changes: changesComputation changes.
	changesComputation typesFilter selection: { }.
	(changesComputation displayedChanges: changesComputation typesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 0.
	self assert: diffBrowser displayedChanges size equals: changesComputation displayedChanges size.
	self assert: (browserWindow model paneNamed: #changesList) presentations first dynamicActions size equals: 0.
]

{ #category : #tests }
DiffBrowserFilterTests >> testChangesWithChangeFilter [
	self assert: diffBrowser displayedChanges size equals: 3.
	changesComputation changesFilter changes: diffBrowser displayedChanges.
	changesComputation changesFilter selection: { FamixMoveChange }.
	(diffBrowser displayedChanges: changesComputation changesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 0.
	self assert: diffBrowser displayedChanges size equals: changesComputation displayedChanges size.
	self assert: changesComputation changes size equals: 3.
	self assert: changesComputation changesFilter selection first equals: FamixMoveChange.
	changesComputation changesFilter selection: { FamixAddChange }.
	(diffBrowser displayedChanges: changesComputation changesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 3.
]

{ #category : #tests }
DiffBrowserFilterTests >> testChangesWithMetricsFilter [
	self assert: diffBrowser displayedChanges size equals: 3.
	changesComputation metricsFilter changes: diffBrowser displayedChanges.
	changesComputation metricsFilter selection: { 'Name Length'-> #(30 40)}  asDictionary.
	(diffBrowser displayedChanges: changesComputation metricsFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 1.
	self assert: changesComputation metricsFilter userThresholds first min equals: 30.
	self assert: changesComputation metricsFilter userThresholds first selector equals: #nameLength.
	self assert: changesComputation metricsFilter userThresholds first max equals: 40.
	self assert: diffBrowser displayedChanges size equals: 1.
	self assert: changesComputation displayedChanges size equals: 1.
	self assert: changesComputation changes size equals:  3
]

{ #category : #tests }
DiffBrowserFilterTests >> testChangesWithTypeFilter [
	self assert: diffBrowser displayedChanges size equals: 3.
	changesComputation typesFilter changes: diffBrowser displayedChanges.
	changesComputation typesFilter selection: { FAMIXClass }.
	(diffBrowser displayedChanges: changesComputation typesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 2.
	self assert: changesComputation typesFilter selection first equals: FAMIXClass.
	changesComputation typesFilter selection: { FAMIXPackage. FAMIXClass }.
	(diffBrowser displayedChanges: changesComputation typesFilter computeResult).
	self assert: diffBrowser displayedChanges size equals: 3.
]

{ #category : #tests }
DiffBrowserFilterTests >> testFilteringAndMetricsDisplayed [
	| wizardSorter |
	wizardSorter := (FamixDiffQueryWizard new browser: diffBrowser).
	self assert: wizardSorter changeMetrics size equals: 8.
	wizardSorter typesSelected remove: #Class.
	self assert: wizardSorter changeMetrics size equals: 1.
]

{ #category : #tests }
DiffBrowserFilterTests >> testSelection [
	| filter |
	filter := (FamixDiffChangesFilter new selection: {FamixAddChange}; yourself).
	self assert:  filter selection first equals: FamixAddChange.
]
