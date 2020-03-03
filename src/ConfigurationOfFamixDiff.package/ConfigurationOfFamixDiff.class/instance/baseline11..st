baselines
baseline11: spec
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
