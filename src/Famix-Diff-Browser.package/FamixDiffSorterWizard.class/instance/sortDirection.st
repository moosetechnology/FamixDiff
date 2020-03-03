sorting
sortDirection
	^ DropListPart new 	
			list: #('Ascending' 'Descending');
			inGroupboxNamed: 'Sort Direction';
			defaultValue: self sorter sortDirection;
			yourself.