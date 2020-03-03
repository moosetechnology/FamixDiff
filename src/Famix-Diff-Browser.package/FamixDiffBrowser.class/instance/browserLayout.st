browser-look
browserLayout
	browser
		row: #baseModel span: 0.15;
		row: #targetModel span: 0.15;
		row: [ :r | r column: #changesList	"; column: #detail " ];
		row: [ :r | r column: #metrics	"; column: #code" ].