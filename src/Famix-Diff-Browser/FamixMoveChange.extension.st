Extension { #name : #FamixMoveChange }

{ #category : #'*Famix-Diff-Browser' }
FamixMoveChange classSide >> displayName [
	^ 'Move' translated
]

{ #category : #'*Famix-Diff-Browser' }
FamixMoveChange classSide >> filterSelector [
	^ #isMove
]
