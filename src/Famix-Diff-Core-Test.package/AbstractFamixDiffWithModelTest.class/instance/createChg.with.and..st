running
createChg: chgClass with: eBase and: eTarget
	| tmpChg|
	tmpChg := chgClass new baseEntity: eBase ; targetEntity:  eTarget ; yourself.
	testChanges at: eBase put: tmpChg.
	testChanges at: eTarget put: tmpChg.
