as yet unclassified
testSortComparator
	self assert: sorter sortComparator equals: #>.
	sorter selection: {#nameLength.'Ascending'}.
	self assert: sorter sortComparator equals: #<.