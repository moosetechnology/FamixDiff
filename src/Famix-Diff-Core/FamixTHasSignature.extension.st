Extension { #name : #FamixTHasSignature }

{ #category : #'*Famix-Diff-Core' }
FamixTHasSignature >> compareSignatureWith: otherEntity givenChanges: changes [

	<famixDiffIdentity>
	^ self signature = otherEntity signature
]
