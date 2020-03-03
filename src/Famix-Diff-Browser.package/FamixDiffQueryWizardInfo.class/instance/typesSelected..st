accessing
typesSelected: aCollection
	typesSelected := OrderedCollection new.
	aCollection do: [:each | typesSelected add: each asSymbol ]