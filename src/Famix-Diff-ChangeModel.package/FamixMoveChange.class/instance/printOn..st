printing
printOn: stream
	super printOn: stream.
	stream
		<< ' -> ';
		<< self targetEntity mooseName