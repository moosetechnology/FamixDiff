I am an abstract class for a change that concern an entity in the source model and an entity of the target model of the diff.

I answer true to #isMatch.

For coherence purpose, I implement #baseEntity and #baseEntity: accessor and mutator that manipulate the entity inst. var inherited from FamixChange.
To access/set the target entity, I define #targetEntity and #targetEntity: messages.