"
I compute the diff of 2 models given. Please use me through FamixDiffOrchestrator.

TODO

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #FamixDiffAbstractComputer,
	#superclass : #FamixDiffAbstract,
	#category : 'Famix-Diff-Core'
}

{ #category : #run }
FamixDiffAbstractComputer >> diff [
	self subclassResponsibility
]
