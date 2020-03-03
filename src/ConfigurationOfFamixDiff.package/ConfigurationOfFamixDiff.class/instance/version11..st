versions
version11: spec
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
