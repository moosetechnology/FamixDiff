Extension { #name : #FAMIXInvocation }

{ #category : #'*Famix-Diff-Core' }
FAMIXInvocation >> matches: otherAssoc resolver: resolver [

	self class = otherAssoc class ifFalse: [ ^ false ].
	"this test could be simplified because the 'from' cannot be a Stub in any association"
	(self myEntity: self source matches: otherAssoc source resolver: resolver) ifFalse: [ ^ false ].
	(self myEntity: self receiver matches: otherAssoc receiver resolver: resolver) ifFalse: [ ^ false ]. "receivers match, now look at candidates"
	^ (self signature = #'new()' and: [ self target isEmpty ]) or: [ "except if surcharged, for invocation to new, there is no candidate"
		  self to anySatisfy: [ :selfCandidate | 
			  otherAssoc to anySatisfy: [ :otherCandidate | self myEntity: selfCandidate matches: otherCandidate resolver: resolver ] ] ]
]
