"
A FamixDiffQueryWizard is a wizard to get input from the user. The input is related to the parameters applied to the FamixChange objects to get the ones corresponding to the user criteria.

Instance Variables
	changesComputation:		<Object>
	changesFilter:		<Object>
	metricsFilter:		<Object>
	queryWizardInfo:		<Object>
	typesFilter:		<Object>

changesComputation
	- xxxxx

changesFilter
	- xxxxx

metricsFilter
	- xxxxx

queryWizardInfo
	- xxxxx

typesFilter
	- xxxxx

"
Class {
	#name : #FamixDiffQueryWizard,
	#superclass : #Object,
	#instVars : [
		'browser',
		'queryWizardInfo'
	],
	#category : 'Famix-Diff-Browser'
}

{ #category : #accessing }
FamixDiffQueryWizard >> browser [
	^ browser
]

{ #category : #accessing }
FamixDiffQueryWizard >> browser: anObject [
	browser := anObject
]

{ #category : #metrics }
FamixDiffQueryWizard >> changeMetrics [
	^ self indicatorsFromChanges values flatten collectAsSet: #label. 
	
]

{ #category : #'filtering-widgets' }
FamixDiffQueryWizard >> changesCheckboxes [
	|checkBoxesPart|
	checkBoxesPart := (MultiCheckboxesPart new
		labels: (self changesComputation changeTypes collect: #asSymbol) asArray; 
		inGroupboxNamed: 'Types of Changes';
		deselectAllOptions;
		yourself).	
	self changesFilter selection ifNotEmpty: [
		self changesFilter selection do: [:aChangeType | checkBoxesPart selectOption: aChangeType displayName asSymbol] ].
	^ checkBoxesPart
]

{ #category : #accessing }
FamixDiffQueryWizard >> changesComputation [
	^ self browser changesComputation
]

{ #category : #filters }
FamixDiffQueryWizard >> changesFilter [
	^ self browser changesComputation changesFilter
]

{ #category : #'filtering-widgets' }
FamixDiffQueryWizard >> createMetricsOn: aCol [
	self changeMetrics
		associationsDo: [ :indicator | 
			|metricsPanePart|
			aCol
				row: [ :row | 
					metricsPanePart := CheckboxPart new
						defaultValue: self defaultValueForCheckBoxes;
						label: indicator value;
						yourself.
					row column: metricsPanePart associatedTo: ('metric', indicator) asSymbol.
						row column:
								(TextFieldPart new
										prefix: 'Min';
										defaultValue: 0)
						associatedTo: ('min', indicator ) asSymbol;
						column:
								(TextFieldPart new
										prefix: 'Max';
										defaultValue: 10)
						associatedTo: ('max', indicator) asSymbol
					 ]
				].
]

{ #category : #'filtering-widgets' }
FamixDiffQueryWizard >> createQueryFilterBox: wizardPane [
	wizardPane column: [:aColumn |
		aColumn row: (self changesCheckboxes) associatedTo: #selectedChanges.
		aColumn row: (self typeCheckBoxes) associatedTo: #selectedTypes].
	wizardPane column: [:aCol | self createMetricsOn: aCol].
	
]

{ #category : #'filtering-widgets' }
FamixDiffQueryWizard >> defaultValueForCheckBoxes [
	^false
]

{ #category : #filtering }
FamixDiffQueryWizard >> filterChangesWith: aDictionaryOfSelections [
	| filterParams|
	filterParams := FamixDiffFilterParameters new
		changes: (((aDictionaryOfSelections at: #selectedChanges) select: #value) collect: #key);
		types: (((aDictionaryOfSelections at:#selectedTypes) select: #value) collect: #key);
		metrics:	(self getMetricsForFilteringFrom: aDictionaryOfSelections);
		yourself.
	self browser displayedChanges: (self browser changesComputation filterChangesWith: filterParams).
	
	
	
]

{ #category : #'filtering-widgets' }
FamixDiffQueryWizard >> filterSelectionChooser [
	|  wizardPane1 wizardControl|
	wizardControl := WizardControl new.
	wizardPane1 := WizardSinglePane new.
	self createQueryFilterBox: wizardPane1.
	wizardControl addPane: wizardPane1.
	wizardControl atEndDo: [ :aDictionaryOfSelections | self filterChangesWith: aDictionaryOfSelections ].
	wizardControl open.
]

{ #category : #metrics }
FamixDiffQueryWizard >> getMetricsForFilteringFrom: aDictionaryOfSelections [
	| metricsSelectors |
	metricsSelectors := (aDictionaryOfSelections associationsSelect: [ :each | (each key includesSubstring: 'metric') and: [ each value ] ]) 	keys collect: [ :assoc | (assoc asString copyAfter: $c) ].
		^ (metricsSelectors collect: [:aSelector |
		(aSelector asSymbol) ->
			{(aDictionaryOfSelections associationsSelect: [ :each | (each key copyAfter: $n) = aSelector]) values first value asInteger . (aDictionaryOfSelections associationsSelect: [ :each | (each key copyAfter: $x) = aSelector]) values first value asInteger}  ]) asDictionary
]

{ #category : #metrics }
FamixDiffQueryWizard >> indicatorsFromChanges [ 
	^ (self browser changesComputation changeMetricsFor: self typesSelected)
]

{ #category : #filters }
FamixDiffQueryWizard >> metricsFilter [
	^ self browser changesComputation metricsFilter
]

{ #category : #accessing }
FamixDiffQueryWizard >> queryWizardInfo [
	^ queryWizardInfo ifNil: [ queryWizardInfo := FamixDiffQueryWizardInfo new typesSelected: self changesComputation typesChanged ]. 	
]

{ #category : #'filtering-widgets' }
FamixDiffQueryWizard >> typeCheckBoxes [
	| checkBoxesPart |
	checkBoxesPart := MultiCheckboxesPart new
		labels: (self changesComputation typesChanged collect: #asSymbol) asArray;
		callback: [ :assoc :part |
				assoc value
						ifTrue: [self queryWizardInfo add: assoc key  ]
						ifFalse: [self queryWizardInfo remove: assoc key ].
						part wizardPane isNotNil
						ifTrue: [part wizardPane removeSubComponentAt: 2.
						part wizardPane column: [:aCol | self createMetricsOn: aCol].
						part wizardPane refresh].
						
						];
		inGroupboxNamed: 'Types of Entities';
		deselectAllOptions;
		yourself.
		self typesFilter selection ifNotEmpty: [
		self typesFilter selection do: [:aType | checkBoxesPart selectOption: aType displayName asSymbol] ].
	^ checkBoxesPart
]

{ #category : #filters }
FamixDiffQueryWizard >> typesFilter [
	^ self browser changesComputation typesFilter
]

{ #category : #accessing }
FamixDiffQueryWizard >> typesSelected [
	^ self queryWizardInfo typesSelected
]
