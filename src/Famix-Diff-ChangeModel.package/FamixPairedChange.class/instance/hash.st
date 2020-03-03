comparing
hash
	^ (super hash bitXor: self targetEntity hash) bitXor: self targetEntityName hash