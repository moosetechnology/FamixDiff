building
buildBrowser
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