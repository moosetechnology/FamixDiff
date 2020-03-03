render
renderDiffList: aPresentation
	aPresentation list
		display: #yourself;
		format: [ :each | (Text fromString: each entity name) addAttribute: (TextColor color: each color) ];
		tags: [ :each | {each entity class displayName} ];
		filterOn: [ :text :each | each entity name includesSubstring: text ];
		dynamicActions: [:list |self menuActions];
		icon: #icon.