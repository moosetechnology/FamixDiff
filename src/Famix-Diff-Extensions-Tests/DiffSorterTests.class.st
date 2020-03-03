Class {
	#name : #DiffSorterTests,
	#superclass : #TestCase,
	#instVars : [
		'sorter'
	],
	#category : 'Famix-Diff-Extensions-Tests'
}

{ #category : #'as yet unclassified' }
DiffSorterTests >> setUp [
	sorter := FamixDiffMetricsSorter new.
]

{ #category : #'as yet unclassified' }
DiffSorterTests >> testSortComparator [
	self assert: sorter sortComparator equals: #>.
	sorter selection: {#nameLength.'Ascending'}.
	self assert: sorter sortComparator equals: #<.
]

{ #category : #'as yet unclassified' }
DiffSorterTests >> testSorterHistory [
	sorter selection: {#nameLength.'Descending'}.
	self assert: sorter sortMetric equals: #nameLength.
	self assert: sorter sortDirection equals: 'Descending'.
	sorter selection: { #mooseName . 'Ascending' }.
	self assert: sorter sortMetric equals: #mooseName.
	self assert: sorter sortDirection equals: 'Ascending'.
]
