Extension { #name : #FAMIXScopingEntity }

{ #category : #'*Famix-Diff-Core' }
FAMIXScopingEntity >> containedEntities [
	^ ((super containedEntities union: self childScopes) union: self globalVariables) union: self functions
]

{ #category : #'*Famix-Diff-Core' }
FAMIXScopingEntity >> isScopingEntity [
	^true
]
