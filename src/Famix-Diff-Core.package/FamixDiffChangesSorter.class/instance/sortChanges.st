accessing
sortChanges
	self changesEntity sort: [ :a :b | a entity hash <= b entity hash ].
	self changesTargetEntity sort: [ :a :b | a targetEntity hash <= b targetEntity hash ]