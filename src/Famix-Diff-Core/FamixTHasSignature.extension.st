Extension { #name : #FamixTHasSignature }

{ #category : #'*Famix-Diff-Core' }
FamixTHasSignature >> compareSignatureWith: otherEntity [

	<famixDiff: #identity priority: 10>
	^ self signature = otherEntity signature
]
