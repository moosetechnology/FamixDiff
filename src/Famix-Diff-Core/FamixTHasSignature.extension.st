Extension { #name : #FamixTHasSignature }

{ #category : #'*Famix-Diff-Core' }
FamixTHasSignature >> compareSignatureWith: otherEntity [

	<famixDiff: #identity priority: 4>
	^ self signature = otherEntity signature
]
