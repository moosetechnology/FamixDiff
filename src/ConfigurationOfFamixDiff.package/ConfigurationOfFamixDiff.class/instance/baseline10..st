baselines
baseline10: spec 
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