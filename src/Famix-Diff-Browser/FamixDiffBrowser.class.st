"
A browser that allow to see the diff of two models.
"
Class {
	#name : #FamixDiffBrowser,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'title',
		'modelSelector',
		'changesComputation',
		'actions',
		'sorterWizard',
		'filterWizard'
	],
	#category : 'Famix-Diff-Browser'
}

{ #category : #accessing }
FamixDiffBrowser >> actions [
	^ actions ifNil: [ OrderedCollection new ]
]

{ #category : #accessing }
FamixDiffBrowser >> actions: anObject [
	actions := anObject
]

{ #category : #'browser-look' }
FamixDiffBrowser >> browserLayout [
	browser
		row: #baseModel span: 0.15;
		row: #targetModel span: 0.15;
		row: [ :r | r column: #changesList	"; column: #detail " ];
		row: [ :r | r column: #metrics	"; column: #code" ].
]

{ #category : #'browser-look' }
FamixDiffBrowser >> browserLook [	
	browser initialExtent: 300 @ 700.
	browser title: self title.
]

{ #category : #building }
FamixDiffBrowser >> buildBrowser [
	browser := GLMTabulator new.
	self browserLook.
	self browserLayout.
	browser transmit
		to: #baseModel;
		andShow: [ :a | self renderDropdownList: a withSelectedIndex: 0 ].
	browser transmit to: #targetModel;
		andShow: [ :a | self renderDropdownList: a withSelectedIndex: self browser entity size ].
	browser transmit
		to: #changesList; 		
		from: #baseModel;
		from: #targetModel;
		when: [ :baseModel :targetModel | baseModel notNil and: [ targetModel notNil ] ];
		transformed: [ :baseModel :targetModel | self changesComputation initializeDiffwith: (baseModel perform: self modelSelector) and: (targetModel perform: self modelSelector).
					self displayedChanges  ];
		andShow: [ :a | 
					self renderDiffList: a ].
	browser transmit
		to: #metrics;
		from: #changesList;
		when: [ :each | each isKindOf: FamixChange ];
		andShow: [ :a | 
					self renderMetricsTable: a].
	^ browser
]

{ #category : #accessing }
FamixDiffBrowser >> changesComputation [
	^ changesComputation ifNil: [ changesComputation := FamixDiffChangesComputation new ]
]

{ #category : #actions }
FamixDiffBrowser >> defaultActions [
	^{GLMGenericAction new title: 'Filter Changes'; action: [ self filterWizard browser: self; filterSelectionChooser ]; icon: MooseIcons famixFunction.
	GLMGenericAction new title: 'Sort Changes'; action: [ self sorterWizard browser: self; sortChooser]; icon: MooseIcons mooseList
	   }
]

{ #category : #accessing }
FamixDiffBrowser >> displayedChanges [
	^ changesComputation displayedChanges
]

{ #category : #accessing }
FamixDiffBrowser >> displayedChanges: anObject [
	changesComputation displayedChanges: anObject.
	((browser paneNamed: #changesList) port: #entity) value: anObject.
	(browser paneNamed: #changesList) update
]

{ #category : #wizards }
FamixDiffBrowser >> filterWizard [
	^ filterWizard ifNil: [filterWizard := FamixDiffQueryWizard new  ]
]

{ #category : #render }
FamixDiffBrowser >> indicatorsFor: aChange [
	^ changesComputation indicatorsFor: aChange
]

{ #category : #actions }
FamixDiffBrowser >> menuActions [
	^ self displayedChanges isEmpty
		ifTrue: [ #() ]
		ifFalse: [ self defaultActions , self actions ]
]

{ #category : #accessing }
FamixDiffBrowser >> modelSelector [
	^ modelSelector ifNil: [ modelSelector := #yourself ]
]

{ #category : #accessing }
FamixDiffBrowser >> modelSelector: anObject [
	modelSelector := anObject
]

{ #category : #render }
FamixDiffBrowser >> renderDiffList: aPresentation [
	aPresentation list
		display: #yourself;
		format: [ :each | (Text fromString: each entity name) addAttribute: (TextColor color: each color) ];
		tags: [ :each | {each entity class displayName} ];
		filterOn: [ :text :each | each entity name includesSubstring: text ];
		dynamicActions: [:list |self menuActions];
		icon: #icon.
]

{ #category : #render }
FamixDiffBrowser >> renderDropdownList: aPres [
	aPres dropDownList 
			display: #yourself;
			format: [:each | [each date asEmailString] on: MessageNotUnderstood do: [each mooseName]]
]

{ #category : #render }
FamixDiffBrowser >> renderDropdownList: aPres withSelectedIndex: index [
	aPres dropDownList
			display: #yourself;
			format: [:each | [each date asEmailString] on: MessageNotUnderstood do: [each mooseName]];
			selectedIndex: index
]

{ #category : #render }
FamixDiffBrowser >> renderMetricsTable: a [
	a table
		display: [ :change | self indicatorsFor: change];
		sorted: [:chg1 :chg2 | chg1 label < chg2 label ];
		column: [ :x | 'Metric' ] evaluated: #label;
		column: 'Delta Value' evaluated: [:each | (each computedValue isKindOf: Number) 
				ifTrue: [each computedValue asInteger asStringWithCommasSigned] ifFalse: [each computedValue asString]]
	
]

{ #category : #wizards }
FamixDiffBrowser >> sorterWizard [
	^ sorterWizard ifNil: [sorterWizard:= FamixDiffSorterWizard new  ]
]

{ #category : #accessing }
FamixDiffBrowser >> title [
	^ title ifNil: [ title := 'Famix Diff Browser'] 
]

{ #category : #accessing }
FamixDiffBrowser >> title: aString [
	title := aString.
]
