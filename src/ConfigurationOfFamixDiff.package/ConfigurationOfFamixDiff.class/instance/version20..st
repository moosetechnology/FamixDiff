versions
version20: spec
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
