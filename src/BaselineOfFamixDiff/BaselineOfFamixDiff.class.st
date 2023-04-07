Class {
	#name : #BaselineOfFamixDiff,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixDiff
}

{ #category : #baselines }
BaselineOfFamixDiff >> baseline: spec [
    <baseline>
    spec
        for: #common
        do: [ 
            self defineDependencies: spec.
            self definePackages: spec.
            self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfFamixDiff >> defineDependencies: spec [
	"No pre-established dependencies.
	Should be applicable to any Famix model"
]

{ #category : #baselines }
BaselineOfFamixDiff >> defineGroups: spec [
 		spec 
			group: 'core' with: #('Famix-Diff-Core' #'Famix-Diff-ChangeModel' );
			group: 'core-tests' with: #('core' 'Famix-Diff-Core-Test' 'Moose-TestResources-ModelDiff-P2' 'Moose-TestResources-ModelDiff-P3' 'Moose-TestResources-ModelDiff-P4') ;
			group: 'extensions' with: #('core' 'Famix-Diff-Extensions' "'Famix-Hash-Extension'" ) ;
			group: 'extensions-tests' with: #('core-tests' 'extensions' 'Famix-Diff-Extensions-Tests' "'Famix-Hash-Extension'" ).

"Ignored for now
			group: 'browser' with: #('core' 'Famix-Diff-Browser' ) ;
			group: 'browser-tests' with: #('core-tests' 'Famix-Diff-Browser-Tests' )."

]

{ #category : #baselines }
BaselineOfFamixDiff >> definePackages: spec [
		spec 
			package: #'Famix-Diff-ChangeModel';
			package: 'Famix-Diff-Core' with: [
				spec requires: #(#'Famix-Diff-ChangeModel' ). ];
			package: #'Famix-Diff-Core-Test' with: [
				spec requires: #('Famix-Diff-Core' ). ];
			package: 'Famix-Diff-Extensions';
			package: #'Famix-Diff-Extensions-Tests' with: [
				spec requires: #('Famix-Diff-Extensions' ). ];
			package: 'Moose-TestResources-ModelDiff-P2';
			package: 'Moose-TestResources-ModelDiff-P3';
			package: 'Moose-TestResources-ModelDiff-P4'";
			package: 'Famix-Hash-Extension'".

"Ignored for now
			package: 'Famix-Diff-Browser' with: [
				spec requires: #('Famix-Diff-Core' ). ];
			package: #'Famix-Diff-Browser-Tests' with: [
				spec requires: #('Famix-Diff-Browser' ). ];"
]
