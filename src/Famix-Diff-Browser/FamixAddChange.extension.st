Extension { #name : #FamixAddChange }

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange >> color [
	^Color green
]

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange class >> displayName [
	^ 'Add' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange class >> filterSelector [
	^ #isAddition
]

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange >> icon [
	^MooseIcons mooseAdd
]
