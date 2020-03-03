as yet unclassified
testSorterHistory
	sorter selection: {#nameLength.'Descending'}.
	self assert: sorter sortMetric equals: #nameLength.
	self assert: sorter sortDirection equals: 'Descending'.
	sorter selection: { #mooseName . 'Ascending' }.
	self assert: sorter sortMetric equals: #mooseName.
	self assert: sorter sortDirection equals: 'Ascending'.