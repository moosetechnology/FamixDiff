Extension { #name : #FamixTHasSignature }

{ #category : #'*Famix-Diff-Core' }
FamixTHasSignature >> compareSignatureWith: otherEntity [

	<famixDiffIdentity>
	^ self signature = otherEntity signature
]
