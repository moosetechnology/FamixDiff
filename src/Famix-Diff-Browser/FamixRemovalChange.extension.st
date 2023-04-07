Extension { #name : #FamixRemovalChange }

{ #category : #'*Famix-Diff-Browser' }
FamixRemovalChange >> color [
	^Color red
]

{ #category : #'*Famix-Diff-Browser' }
FamixRemovalChange class >> displayName [
	^ 'Remove' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixRemovalChange class >> filterSelector [
	^ #isRemoval
]

{ #category : #'*Famix-Diff-Browser' }
FamixRemovalChange >> icon [
	^MooseIcons mooseRemove
]

{ #category : #'*Famix-Diff-Browser' }
FamixRemovalChange >> signSelector [
	^ #negated
]
