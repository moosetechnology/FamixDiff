printing
printOn: stream
	stream
		<< self ppname;
		<< '(';
		<< entity class name;
		<< ') ';
		<< entity mooseName