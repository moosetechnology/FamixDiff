running
testSorterMetricName
	changesComputation metricsSorter selection: {'Name Length'. 'Ascending' }.
	self assert: changesComputation metricsSorter sortSelector equals: #nameLength.
	changesComputation metricsSorter selection: {'Number Of attributes'. 'Ascending' }.
	self assert: changesComputation metricsSorter sortSelector equals: #numberOfAttributes.