Class {
	#name : #A3diff,
	#superclass : #Object,
	#instVars : [
		'att1',
		'att2'
	],
	#category : 'Moose-TestResources-ModelDiff-P3'
}

{ #category : #'as yet unclassified' }
A3diff >> b3 [
	B3diff new.
	att2:= 'toto'
]

{ #category : #'as yet unclassified' }
A3diff >> c3 [
	"comment stating purpose of message"
	| toto var2 var3 var4 |

	toto := C3diff new.
]
