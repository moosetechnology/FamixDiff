Extension { #name : 'TEntityMetaLevelDependency' }

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> can: baseSize beSameAs: targetSize withThreashold: tolerance [
	"Check if two collections have the same size within a certain percentage tolerance."

	| absoluteDifference averageSize maxAllowedDifference |
	absoluteDifference := (baseSize - targetSize) abs.

	averageSize := baseSize + targetSize / 2.


	maxAllowedDifference := averageSize * (tolerance / 1).


	^ absoluteDifference abs <= maxAllowedDifference
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> compareParentsWith: otherEntity resolver: resolver [
	"I check that the parents of both entities are the same."

	<famixDiff: #identity priority: 5>
	<famixDiff: #rename priority: 5>
	| baseParents targetParents |
	baseParents := self containers.
	targetParents := otherEntity containers.

	baseParents size = targetParents size ifFalse: [ ^ false ].

	baseParents do: [ :baseParent |
			targetParents
				detect: [ :targetParent | "We delegate the comparison to the resolver because it's possible a parent is the same but got renamed. This should deal with this case."
					resolver is: baseParent sameAs: targetParent ]
				ifNone: [ ^ false "A parent of the base entity does not have a matching parent so we escape." ] ].

	^ true
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> famixDiffMethodsToApplyFor: aPragmaName [

	| selectors tempSelectors |
	tempSelectors := (((Pragma allNamed: #famixDiff:priority: from: self class to: MooseEntity) select: [ :pragma |
		                   (pragma argumentNamed: #famixDiff) = aPragmaName ]) sorted: [ :pragma | pragma argumentNamed: #priority ] ascending) collect: [ :pragma |
		                 pragma methodSelector ].

	"Since we can have inheritance we can have multiple pragmas for methods with the same name and we do not want to apply them multiple times."
	selectors := OrderedCollection new.
	tempSelectors do: [ :selector | (selectors includes: selector) ifFalse: [ selectors add: selector ] ].

	^ selectors
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> generateMethodNamed: aString basedOnPragmaName: aPragmaName [
	"See TEntityMetaLevelDependency>>#identityMatch:resolver: to know why I am needed."

	| methodBody |
	methodBody := String streamContents: [ :stream |
		              self printFamixDiffSelector: aString on: stream.
		              stream
			              cr;
			              cr;
			              tab.
		              (self famixDiffMethodsToApplyFor: aPragmaName)
			              do: [ :selector |
				              stream nextPutAll: '(self '.
				              self printFamixDiffSelector: selector on: stream.
				              stream nextPutAll: ') ifFalse: [ ^ false ].' ]
			              separatedBy: [
				              stream
					              cr;
					              tab ].
		              stream
			              cr;
			              tab;
			              nextPutAll: ' ^ true' ].
	self class compile: methodBody classified: FamixDiffResolver generatedPackageProtocol
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> hasEqualContentAndDependencies: otherEntity resolver: resolver [
	"In order to know if an entity was moved or renamed we compare its children and its dependencies. If they are the same we can consider an entity is the same.
	
	Tolerance is used to give some flexibility because an entity can be renamed and slightly modified.
	tolerance 0 => both entities must be strictly equals
	tolerance=1 (100%) => entities can be completly different"

	<famixDiff: #rename priority: 10>
	<famixDiff: #move priority: 10>
	| baseChildren targetChildren intersect baseOutgoingDependencies targetOutgoingDependencies baseIncomingDependencies targetIncomingDependencies |
	baseChildren := self containedEntities.
	targetChildren := otherEntity containedEntities.

	baseOutgoingDependencies := self queryAllLocalOutgoing.
	targetOutgoingDependencies := otherEntity queryAllLocalOutgoing.

	baseIncomingDependencies := self queryAllLocalIncoming.
	targetIncomingDependencies := otherEntity queryAllLocalIncoming.

	"If we have nothing in the class we consider they are different."
	(baseChildren isEmpty and: [ baseOutgoingDependencies isEmpty and: [ baseIncomingDependencies isEmpty ] ]) ifTrue: [
		^ false ].
	(targetChildren isEmpty and: [ targetOutgoingDependencies isEmpty and: [ targetIncomingDependencies isEmpty ] ])
		ifTrue: [ ^ false ].

	"This is for perf. If the number of entity is too different, no need to compare them."
	(self
		 can: baseChildren size + baseOutgoingDependencies size + baseIncomingDependencies size
		 beSameAs: targetChildren size + targetOutgoingDependencies size + targetIncomingDependencies size
		 withThreashold: resolver tolerance) ifFalse: [ ^ false ].

	intersect := OrderedCollection new.

	"Since we did not treat the children with the resolver  yet we do not check via the resolver if they are the same entities because even if they are renamed we will not know it yet."
	intersect addAll:
		(baseChildren select: [ :baseChild | targetChildren anySatisfy: [ :targetChild | baseChild name = targetChild name ] ]).

	intersect addAll: (baseOutgoingDependencies select: [ :baseDependency |
				 targetOutgoingDependencies anySatisfy: [ :targetDependency |
						 targetDependency class = baseDependency class and: [
								 (baseDependency target isNotNil and: [ targetDependency target isNotNil ]) and: [ "<=== THIS SHOULD NOT BE HERE. Target should never be nil but verveineJ has a bug. Remove this once the bug is fixed."
										 baseDependency allTargets allSatisfy: [ :baseTarget |
											 targetDependency allTargets anySatisfy: [ :targetTarget | baseTarget name = targetTarget name ] ] ] ] ] ]).

	intersect addAll: (baseIncomingDependencies select: [ :baseDependency |
				 targetIncomingDependencies anySatisfy: [ :targetDependency |
						 targetDependency class = baseDependency class and: [
								 (baseDependency source isNotNil and: [ targetDependency source isNotNil ]) and: [ "<=== THIS SHOULD NOT BE HERE. Target should never be nil but verveineJ has a bug. Remove this once the bug is fixed."
									 baseDependency source name = targetDependency source name ] ] ] ]).

	intersect size / (baseChildren size + baseOutgoingDependencies size + baseIncomingDependencies size)
	>= (1 - resolver tolerance) ifFalse: [ ^ false ].
	intersect size / (targetChildren size + targetOutgoingDependencies size + targetIncomingDependencies size)
	>= (1 - resolver tolerance) ifFalse: [ ^ false ].
	^ true
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> hasSameClassAs: otherEntity resolver: aResolver [

	<famixDiff: #identity priority: 1>
	<famixDiff: #rename priority: 1>
	<famixDiff: #move priority: 1>
	^ self class = otherEntity class
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> identityMatch: otherEntity resolver: resolver [
	"We consider that the entities are identical if all comparators declared for the entity with the following pragma are matching."

	"The code here is a little weird but it is for performance reasons. Each entity will apply some filters to know if they are identical or not. Those filters are implemented on different traits composing the entities and we collect them via a pragma. But it takes some time to collect them.
	In order to speed up things, the first time we get here for a specific class, we will have a message not understood and we will generate a method collecting all the filters and applying them.
	Once the computation is finished, the resolver will remove this generated code from the system."
	^ [ self isIdenticalTo: otherEntity resolver: resolver ]
		  on: MessageNotUnderstood
		  do: [
			  self generateMethodNamed: #isIdenticalTo:resolver: basedOnPragmaName: #identity.
			  self isIdenticalTo: otherEntity resolver: resolver ]
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> isNotStubWith: otherEntity resolver: aResolver [

	"stubs either are identical or nothing, no renaming or moving allowed"

	<famixDiff: #rename priority: 1.5>
	<famixDiff: #move priority: 1.5>
	^ self isStub not and: [ otherEntity isStub not ]
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> moveMatch: otherEntity resolver: resolver [

	(self compareParentsWith: otherEntity resolver: resolver) ifTrue: [ ^ false ].

	"See comment in #identityMatch:resolver: to understand what we are doing here"
	^ [ self isMoveOf: otherEntity resolver: resolver ]
		  on: MessageNotUnderstood
		  do: [
			  self generateMethodNamed: #isMoveOf:resolver: basedOnPragmaName: #move.
			  self isMoveOf: otherEntity resolver: resolver ]
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> printFamixDiffSelector: aString on: stream [

	stream
		nextPutAll: (aString splitOn: $:) first;
		nextPutAll: ': otherEntity ';
		nextPutAll: (aString splitOn: $:) second;
		nextPutAll: ': resolver'
]

{ #category : '*Famix-Diff-Core' }
TEntityMetaLevelDependency >> renameMatch: otherEntity resolver: resolver [

	(self isNamedEntity and: [ self name ~= otherEntity name ]) ifFalse: [ ^ false ].

	"See comment in #identityMatch:resolver: to understand what we are doing here"
	^ [ self isRenameOf: otherEntity resolver: resolver ]
		  on: MessageNotUnderstood
		  do: [
			  self generateMethodNamed: #isRenameOf:resolver: basedOnPragmaName: #rename.
			  self isRenameOf: otherEntity resolver: resolver ]
]
