Extension { #name : #FamixRenameChange }

{ #category : #'*Famix-Diff-Browser' }
FamixRenameChange classSide >> displayName [
	^ 'Rename' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixRenameChange classSide >> filterSelector [
	^ #isRename
]
