change-creation
makeChange: changeClass with: baseEntity with: targetEntity
	^ changeClass new
			baseEntity: baseEntity ;
			targetEntity: targetEntity ;
			yourself.
