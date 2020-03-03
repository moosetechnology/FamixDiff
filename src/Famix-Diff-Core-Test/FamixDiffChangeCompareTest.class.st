Class {
	#name : #FamixDiffChangeCompareTest,
	#superclass : #AbstractFamixDiffTest,
	#category : 'Famix-Diff-Core-Test'
}

{ #category : #running }
FamixDiffChangeCompareTest >> setUp [
	self model: (self importModelNamed: 'base' fromPackages: #(#'Moose-TestResources-ModelDiff-P4' #'Moose-TestResources-ModelDiff-P3'))
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddAdd [
	| att cl add1 add2 |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	add1 := FamixAddChange new entity: att.
	add2 := FamixAddChange new entity: cl.
	self assert: (add2 comeBefore: add1).
	self deny: (add1 comeBefore: add2)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddMove [
	| att cl add1 mv |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	add1 := FamixAddChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: add1).
	self deny: (add1 comeBefore: mv)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddMove2 [
	| att att2 add1 mv |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	att2 := self model entityNamed: 'Smalltalk::A3diff.att2'.
	
	add1 := FamixAddChange new entity: att2.
	mv := FamixMoveChange new entity: att.
	self assert: (add1 comeBefore: mv).
	self deny: (mv comeBefore: add1).
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddMove3 [
	| att ass add1 mv |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	ass := (self model entityNamed: 'Smalltalk::A3diff') incomingReferences first.
	
	add1 := FamixAddChange new entity: ass.
	mv := FamixMoveChange new entity: att.
	self assert: (mv comeBefore: add1 ).
	self deny: (add1 comeBefore: mv).
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddRemoval [
	| att cl add1 rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: att.
	add1 := FamixAddChange new entity: cl.
	self assert: (add1 comeBefore: rm ).
	self deny: (rm comeBefore: add1)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddRemoval2 [
	| att cl add1 rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: cl.
	add1 := FamixAddChange new entity: att.
	self deny: (add1 comeBefore: rm ).
	self assert: (rm comeBefore: add1)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddRename [
	| att cl add1 rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRenameChange new entity: att.
	add1 := FamixAddChange new entity: cl.
	self assert: (add1 comeBefore: rn ).
	self deny: (rn comeBefore: add1)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddRename2 [
	| att cl add1 rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRenameChange new entity: cl.
	add1 := FamixAddChange new entity: att.
	self deny: (add1 comeBefore: rn ).
	self assert: (rn comeBefore: add1)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddVersion [
	| att cl add1 vs n1 tmpModel |
	tmpModel := MooseModel new.
	att := FAMIXAttribute new parentType: (FAMIXClass new); mooseModel: tmpModel; yourself.
	n1 := FAMIXNamespace new mooseModel: tmpModel; yourself.
	cl := FAMIXClass new name: #C1; container: n1; mooseModel: tmpModel; yourself.
	
	add1 := FamixAddChange new entity: att.
	vs := FamixVersionChange new entity: cl.
	self assert: (vs comeBefore: add1 ).
	self deny: (add1 comeBefore: vs)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareAddVersion2 [
	| cl1 cl add1 vs |
	cl1 := FAMIXClass new
		name: 'toto';
		container: FAMIXNamespace new.
	cl := FAMIXClass new
		name: 'titi';
		container: FAMIXNamespace new.
	add1 := FamixAddChange new entity: cl1.
	vs := FamixVersionChange new entity: cl.
	self assert: (vs comeBefore: add1).
	self deny: (add1 comeBefore: vs)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareMoveMove [
	| att cl mv1 mv tmpModel |
	tmpModel := MooseModel new.
	att := FAMIXAttribute new name: 'att' ; parentType: FAMIXClass new; mooseModel: tmpModel ; yourself.
	cl := FAMIXClass new name: 'cl' ; container: FAMIXPackage new; mooseModel: tmpModel ; yourself.
	mv1 := FamixMoveChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: mv1 ).
	self deny: (mv1 comeBefore: mv)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareMoveRemoval [
	| att cl mv rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: rm ).
	self deny: (rm comeBefore: mv)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareMoveRemoval2 [
	| att cl mv rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: cl.
	mv := FamixMoveChange new entity: att.
	self deny: (mv comeBefore: rm ).
	self assert: (rm comeBefore: mv)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareMoveRename [
	| att cl mv rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRemovalChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self assert: (mv comeBefore: rn ).
	self deny: (rn comeBefore: mv)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareMoveRename2 [
	| att cl mv rn |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rn := FamixRemovalChange new entity: cl.
	mv := FamixMoveChange new entity: att.
	self deny: (mv comeBefore: rn ).
	self assert: (rn comeBefore: mv)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareMoveVersion [
	| att cl vs mv tmpModel |
	tmpModel := MooseModel new.
	att := FAMIXAttribute new parentType: FAMIXClass new; mooseModel: tmpModel; yourself.
	cl := FAMIXClass new name: 'cl'; container: FAMIXPackage new; mooseModel: tmpModel; 
			yourself.
	vs := FamixVersionChange new entity: att.
	mv := FamixMoveChange new entity: cl.
	self deny: (vs comeBefore: mv).
	self assert: (mv comeBefore: vs)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareRenameRemoval [
	| att cl rn rm |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	rm := FamixRemovalChange new entity: att.
	rn := FamixRenameChange new entity: cl.
	self assert: (rn comeBefore: rm ).
	self deny: (rm comeBefore: rn)
]

{ #category : #tests }
FamixDiffChangeCompareTest >> testCompareVersionVersion [
	| att cl vs1 vs2 |
	att := self model entityNamed: 'Smalltalk::A3diff.att1'.
	cl := self model entityNamed: 'Smalltalk::A3diff'.
	vs1 := FamixVersionChange new entity: att.
	vs2 := FamixVersionChange new entity: cl.
	self assert: (vs2 comeBefore: vs1 ).
	self deny: (vs1 comeBefore: vs2)
]
