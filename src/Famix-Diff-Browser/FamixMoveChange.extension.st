Extension { #name : #FamixMoveChange }

{ #category : #'*Famix-Diff-Browser' }
FamixMoveChange class >> displayName [
	^ 'Move' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixMoveChange class >> filterSelector [
	^ #isMove
]
