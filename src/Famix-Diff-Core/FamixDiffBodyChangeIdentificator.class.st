Class {
	#name : #FamixDiffBodyChangeIdentificator,
	#superclass : #FamixDiffAbstractPostOperator,
	#category : 'Famix-Diff-Core'
}

{ #category : #accessing }
FamixDiffBodyChangeIdentificator >> run [
	| allIdemMethodsChanges hashChangedMethodChanges |
	allIdemMethodsChanges := self result select: [ :change | change isVersion and: [ change entity isMethod ] ].
	hashChangedMethodChanges := allIdemMethodsChanges select: [ :change | change baseEntity bodyHash ~= change targetEntity bodyHash ].
	self result addAll: (hashChangedMethodChanges collect: [ :aChange | aChange as: FamixBodyChange ]).
	self result removeAll: hashChangedMethodChanges
]
