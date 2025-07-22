Extension { #name : 'FamixTHasSignature' }

{ #category : '*Famix-Diff-Core' }
FamixTHasSignature >> compareSignatureWith: otherEntity resolver: aResolver [

	<famixDiff: #identity priority: 4>
	^ self signature = otherEntity signature
]
