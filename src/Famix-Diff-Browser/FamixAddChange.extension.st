Extension { #name : #FamixAddChange }

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange >> color [
	^Color green
]

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange classSide >> displayName [
	^ 'Add' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange classSide >> filterSelector [
	^ #isAddition
]

{ #category : #'*Famix-Diff-Browser' }
FamixAddChange >> icon [
	^MooseIcons mooseAdd
]
