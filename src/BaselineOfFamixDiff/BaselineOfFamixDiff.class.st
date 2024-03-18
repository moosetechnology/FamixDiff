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
			package: 'Famix-Diff-Core-Test' with: [ spec requires: #( 'Famix-Diff-Core' ) ];
			package: 'Famix-Diff-Extensions';
			package: 'Famix-Diff-Extensions-Tests' with: [ spec requires: #( 'Famix-Diff-Extensions' ) ];
			package: 'Moose-TestResources-ModelDiff-P2';
			package: 'Moose-TestResources-ModelDiff-P3';
			package: 'Moose-TestResources-ModelDiff-P4'.
		spec
			group: 'core' with: #( 'Famix-Diff-Core' 'Famix-Diff-ChangeModel' );
			group: 'core-tests'
			with: #( 'core' 'Famix-Diff-Core-Test' 'Moose-TestResources-ModelDiff-P2' 'Moose-TestResources-ModelDiff-P3' 'Moose-TestResources-ModelDiff-P4' );
			group: 'extensions' with: #( 'core' 'Famix-Diff-Extensions' );
			group: 'extensions-tests' with: #( 'core-tests' 'extensions' 'Famix-Diff-Extensions-Tests' ) ]
]
