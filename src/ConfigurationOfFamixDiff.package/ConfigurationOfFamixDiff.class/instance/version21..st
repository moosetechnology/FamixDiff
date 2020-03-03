versions
version21: spec
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
