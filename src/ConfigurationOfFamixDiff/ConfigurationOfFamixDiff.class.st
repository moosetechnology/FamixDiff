Class {
	#name : #ConfigurationOfFamixDiff,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : 'ConfigurationOfFamixDiff'
}

{ #category : #private }
ConfigurationOfFamixDiff class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #testing }
ConfigurationOfFamixDiff class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfFamixDiff class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfFamixDiff class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfFamixDiff class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfFamixDiff class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfFamixDiff >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec author: 'Anne Etien'.
		spec description: 'work on Pharo 2.0-3.0-5.0'.
		
		spec repository: 'http://smalltalkhub.com/mc/AnneEtien/FamixDiff/main'.
		spec 
			package: 'Moose-TestResources-ModelDiff-P2';
			package: 'Moose-TestResources-ModelDiff-P3';
			package: 'Moose-TestResources-ModelDiff-P4';
			package: 'Famix-Diff-Core' ;
			package: 'Famix-Diff-Extensions' ;
			package: 'Famix-Diff-Test' with: [ spec requires: 'Famix-Diff-Core'];
			package: 'Famix-Diff-Browser' with: [ spec requires: 'Famix-Diff-Core'].
		spec group: 'Core' with: #( 'Famix-Diff-Core' ).

		spec group: 'Tests' with: #( 'Famix-Diff-Test' 'Moose-TestResources-ModelDiff-P2' 'Moose-TestResources-ModelDiff-P3' 'Moose-TestResources-ModelDiff-P4').
	]
]

{ #category : #baselines }
ConfigurationOfFamixDiff >> baseline11: spec [
	<version: '1.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/FamixDiff/main/'.
		spec 
			package: 'Famix-Diff-Browser' with: [
				spec requires: #('Famix-Diff-Core' ). ];
			package: #'Famix-Diff-Browser-Tests' with: [
				spec requires: #('Famix-Diff-Browser' ). ];
			package: 'Famix-Diff-Core';
			package: #'Famix-Diff-Core-Test' with: [
				spec requires: #('Famix-Diff-Core' ). ];
			package: 'Famix-Diff-Extensions';
			package: #'Famix-Diff-Extensions-Tests' with: [
				spec requires: #('Famix-Diff-Extensions' ). ];
			package: 'Moose-TestResources-ModelDiff-P2';
			package: 'Moose-TestResources-ModelDiff-P3';
			package: 'Moose-TestResources-ModelDiff-P4'.
		spec 
			group: 'Core' with: #('Famix-Diff-Core' );
			group: 'Tests' with: #('Moose-TestResources-ModelDiff-P2' 'Moose-TestResources-ModelDiff-P3' 'Moose-TestResources-ModelDiff-P4' #'Famix-Diff-Core-Test' #'Famix-Diff-Browser-Tests' #'Famix-Diff-Extensions-Tests' ). ].

]

{ #category : #baselines }
ConfigurationOfFamixDiff >> baseline12: spec [
	<version: '1.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/FamixDiff/main/'.
		spec 
			package: 'Famix-Diff-Browser' with: [
				spec requires: #('Famix-Diff-Core' ). ];
			package: #'Famix-Diff-Browser-Tests' with: [
				spec requires: #('Famix-Diff-Browser' ). ];
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
			package: 'Moose-TestResources-ModelDiff-P4';
			package: 'Famix-Hash-Extension'.
		spec 
			group: 'ChangeModel' with: #(#'Famix-Diff-ChangeModel' );
			group: 'HashExtension' with: #(#'Famix-Hash-Extension' );
			group: 'Core' with: #('Famix-Diff-Core' #'Famix-Diff-ChangeModel' );
			group: 'Tests' with: #('Moose-TestResources-ModelDiff-P2' 'Moose-TestResources-ModelDiff-P3' 'Moose-TestResources-ModelDiff-P4' #'Famix-Diff-Core-Test' #'Famix-Diff-Browser-Tests' #'Famix-Diff-Extensions-Tests' #'Famix-Hash-Extension' ). ].

]

{ #category : #baselines }
ConfigurationOfFamixDiff >> default: spec [ 
	<version: 'default'>
	
	self baseline10: spec.
]

{ #category : #'symbolic versions' }
ConfigurationOfFamixDiff >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.2-baseline'.

	spec for: #'pharo2.x' version: '1.0-baseline'.

	spec for: #'pharo3.x' version: '1.0-baseline'.

	spec for: #'pharo4.x' version: '1.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfFamixDiff >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]

{ #category : #'symbolic versions' }
ConfigurationOfFamixDiff >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.1'.

]

{ #category : #versions }
ConfigurationOfFamixDiff >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '12/26/2015 12:09'.
		spec 
			package: 'Moose-TestResources-ModelDiff-P2' with: 'Moose-TestResources-ModelDiff-P2-NicolasAnquetil.2';
			package: 'Moose-TestResources-ModelDiff-P3' with: 'Moose-TestResources-ModelDiff-P3-VincentBlondeau.10';
			package: 'Moose-TestResources-ModelDiff-P4' with: 'Moose-TestResources-ModelDiff-P4-VincentBlondeau.7';
			package: 'Famix-Diff-Core' with: 'Famix-Diff-Core-VincentBlondeau.44';
			package: 'Famix-Diff-Extensions' with: 'Famix-Diff-Extensions-usmanbhatti.7';
			package: 'Famix-Diff-Test' with: 'Famix-Diff-Test-NicolasAnquetil.43';
			package: 'Famix-Diff-Browser' with: 'Famix-Diff-Browser-usmanbhatti.31'. ].

]

{ #category : #versions }
ConfigurationOfFamixDiff >> version11: spec [
	<version: '1.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1 - minor improvement in browser so releasing a new version'.
		spec author: 'UsmanBhatti'.
		spec timestamp: '01/15/2016 18:09'.
		spec 
			package: 'Moose-TestResources-ModelDiff-P2' with: 'Moose-TestResources-ModelDiff-P2-NicolasAnquetil.2';
			package: 'Moose-TestResources-ModelDiff-P3' with: 'Moose-TestResources-ModelDiff-P3-VincentBlondeau.10';
			package: 'Moose-TestResources-ModelDiff-P4' with: 'Moose-TestResources-ModelDiff-P4-VincentBlondeau.7';
			package: 'Famix-Diff-Core' with: 'Famix-Diff-Core-VincentBlondeau.44';
			package: 'Famix-Diff-Extensions' with: 'Famix-Diff-Extensions-usmanbhatti.7';
			package: 'Famix-Diff-Test' with: 'Famix-Diff-Test-NicolasAnquetil.43';
			package: 'Famix-Diff-Browser' with: 'Famix-Diff-Browser-usmanbhatti.32'. ].

]

{ #category : #versions }
ConfigurationOfFamixDiff >> version20: spec [
	<version: '2.0' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '9/15/2016 12:06'.
		spec 
			package: 'Famix-Diff-Browser' with: 'Famix-Diff-Browser-VincentBlondeau.35';
			package: #'Famix-Diff-Browser-Tests' with: 'Famix-Diff-Browser-Tests-VincentBlondeau.1';
			package: 'Famix-Diff-Core' with: 'Famix-Diff-Core-VincentBlondeau.46';
			package: #'Famix-Diff-Core-Test' with: 'Famix-Diff-Core-Test-VincentBlondeau.1';
			package: 'Famix-Diff-Extensions' with: 'Famix-Diff-Extensions-VincentBlondeau.8';
			package: #'Famix-Diff-Extensions-Tests' with: 'Famix-Diff-Extensions-Tests-VincentBlondeau.1';
			package: 'Moose-TestResources-ModelDiff-P2' with: 'Moose-TestResources-ModelDiff-P2-VincentBlondeau.3';
			package: 'Moose-TestResources-ModelDiff-P3' with: 'Moose-TestResources-ModelDiff-P3-VincentBlondeau.11';
			package: 'Moose-TestResources-ModelDiff-P4' with: 'Moose-TestResources-ModelDiff-P4-VincentBlondeau.8'. ].

]

{ #category : #versions }
ConfigurationOfFamixDiff >> version21: spec [
	<version: '2.1' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '11/4/2016 12:14'.
		spec 
			package: 'Famix-Diff-Browser' with: 'Famix-Diff-Browser-VincentBlondeau.36';
			package: #'Famix-Diff-Browser-Tests' with: 'Famix-Diff-Browser-Tests-VincentBlondeau.1';
			package: #'Famix-Diff-ChangeModel' with: 'Famix-Diff-ChangeModel-VincentBlondeau.1';
			package: 'Famix-Diff-Core' with: 'Famix-Diff-Core-VincentBlondeau.60';
			package: #'Famix-Diff-Core-Test' with: 'Famix-Diff-Core-Test-JulienDelplanque.3';
			package: 'Famix-Diff-Extensions' with: 'Famix-Diff-Extensions-VincentBlondeau.8';
			package: #'Famix-Diff-Extensions-Tests' with: 'Famix-Diff-Extensions-Tests-VincentBlondeau.1';
			package: 'Moose-TestResources-ModelDiff-P2' with: 'Moose-TestResources-ModelDiff-P2-VincentBlondeau.3';
			package: 'Moose-TestResources-ModelDiff-P3' with: 'Moose-TestResources-ModelDiff-P3-VincentBlondeau.11';
			package: 'Moose-TestResources-ModelDiff-P4' with: 'Moose-TestResources-ModelDiff-P4-VincentBlondeau.8'. ].

]
