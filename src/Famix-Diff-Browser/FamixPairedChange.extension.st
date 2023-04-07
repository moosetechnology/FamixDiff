Extension { #name : #FamixPairedChange }

{ #category : #'*Famix-Diff-Browser' }
FamixPairedChange >> changeMetrics [
	^ self entityChangeIndicators collect: [:anIndicator |
			anIndicator computedValue: ((self targetEntity perform: anIndicator selector) - (self targetEntity perform: anIndicator selector)).
			anIndicator
			]
]

{ #category : #'*Famix-Diff-Browser' }
FamixPairedChange >> color [
	^Color blue
]

{ #category : #'*Famix-Diff-Browser' }
FamixPairedChange class >> displayName [
	^ 'Modification' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixPairedChange >> icon [
	^MooseIcons mooseEditor
]
