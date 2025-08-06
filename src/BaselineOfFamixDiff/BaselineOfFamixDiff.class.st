Class {
	#name : 'BaselineOfFamixDiff',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFamixDiff',
	#package : 'BaselineOfFamixDiff'
}

{ #category : 'baselines' }
BaselineOfFamixDiff >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec
				package: 'Famix-Diff-ChangeModel';
				package: 'Famix-Diff-Core' with: [ spec requires: #( 'Famix-Diff-ChangeModel' ) ];
				package: 'Famix-Diff-Core-Tests' with: [ spec requires: #( 'Famix-Diff-Core' ) ].
			spec
				group: 'core' with: #( 'Famix-Diff-Core' 'Famix-Diff-ChangeModel' );
				group: 'core-tests' with: #( 'core' 'Famix-Diff-Core-Tests' ) ].

	spec for: #NoFamix do: [
			self famix: spec.
			spec package: 'Famix-Diff-Core' with: [ spec requires: #( 'Famix' ) ] ]
]

{ #category : 'accessing' }
BaselineOfFamixDiff >> customProjectAttributes [

	'BaselineOfFamix' asPackageIfAbsent: [ ^ #( #NeedsFamix ) ].
	^ #(  )
]

{ #category : 'dependencies' }
BaselineOfFamixDiff >> famix: spec [

	spec baseline: 'Famix' with: [ spec repository: 'github://moosetechnology/Famix:development/src' ]
]
