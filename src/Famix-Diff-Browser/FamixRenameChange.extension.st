Extension { #name : #FamixRenameChange }

{ #category : #'*Famix-Diff-Browser' }
FamixRenameChange class >> displayName [
	^ 'Rename' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixRenameChange class >> filterSelector [
	^ #isRename
]
