Extension { #name : #FAMIXInvocation }

{ #category : #'*Famix-Diff-Core' }
FAMIXInvocation >> matches: otherAssoc givenChanges: entityChanges [

	self famixClass = otherAssoc famixClass ifFalse: [ ^ false ].
	"this test could be simplified because the 'from' cannot be a Stub in any association"
	(self
		 myEntity: self source
		 matches: otherAssoc source
		 givenChanges: entityChanges) ifFalse: [ ^ false ].
	(self
		 myEntity: self receiver
		 matches: otherAssoc receiver
		 givenChanges: entityChanges) ifFalse: [ ^ false ]. "receivers match, now look at candidates"
	^ (self signature = #'new()' and: [ self target isEmpty ]) or: [ 
		  self to anySatisfy: [ :selfCandidate | 
			  otherAssoc to anySatisfy: [ :otherCandidate | 
				  self
					  myEntity: selfCandidate
					  matches: otherCandidate
					  givenChanges: entityChanges ] ] ] "except if surcharged, for invocation to new, there is no candidate"
]
