Class {
	#name : #BaselineOfFamixDiff,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixDiff
}

{ #category : #baselines }
BaselineOfFamixDiff >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'Famix-Diff-ChangeModel';
			package: 'Famix-Diff-Core' with: [ spec requires: #( 'Famix-Diff-ChangeModel' ) ];
			package: 'Famix-Diff-Core-Tests' with: [ spec requires: #( 'Famix-Diff-Core' ) ];
			package: 'Famix-Diff-TestResource-P1';
			package: 'Famix-Diff-TestResource-P2';
			package: 'Famix-Diff-TestResource-P3'.
		spec
			group: 'core' with: #( 'Famix-Diff-Core' 'Famix-Diff-ChangeModel' );
			group: 'core-tests' with: #( 'core' 'Famix-Diff-Core-Tests' 'Famix-Diff-TestResource-P1' 'Famix-Diff-TestResource-P2' 'Famix-Diff-TestResource-P3' ) ]
]
