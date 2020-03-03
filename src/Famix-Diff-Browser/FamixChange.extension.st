Extension { #name : #FamixChange }

{ #category : #'*Famix-Diff-Browser' }
FamixChange >> changeMetrics [
	^ self entityChangeIndicators collect: [:anIndicator |
			(anIndicator computedValue: ((self entity perform: anIndicator selector) perform: self signSelector)).
			anIndicator
			]
]

{ #category : #'*Famix-Diff-Browser' }
FamixChange >> color [
	^ self subclassResponsibility
]

{ #category : #'*Famix-Diff-Browser' }
FamixChange >> entityChangeIndicators [
	^ self entity changeMetrics collect: [ :assoc | FamixDiffIndicator selector: assoc value label: assoc key ]
]

{ #category : #'*Famix-Diff-Browser' }
FamixChange >> icon [
	^ self subclassResponsibility
]

{ #category : #'*Famix-Diff-Browser' }
FamixChange >> signSelector [
	^ #yourself
]
