# FamixDiff: Developper Documentation

The computation of the diff happens in the class `FamixDiffResolver` and is launched via the method `#computeDiff`.

We start by doing the diff between the entities, then we do the diff between the associations.

<!-- TOC -->

- [FamixDiff: Developper Documentation](#famixdiffdevelopper-documentation)
  - [Diff between entities](#diff-between-entities)
    - [General diff logic](#general-diff-logic)
    - [Comparison logic](#comparison-logic)
      - [Customize the comparison depending on the metamodel](#customize-the-comparison-depending-on-the-metamodel)
    - [Optimization logic](#optimization-logic)
  - [Diff between associations](#diff-between-associations)

<!-- /TOC -->

## Diff between entities

First we start by computing the diff between entities. 

This step can be tricky for multiple reasons and requires some wild optimizations in order to be time effictive. We will present those mecanisms in this section. 

### General diff logic

<p align="center">
  <img src="process.png">
</p>

The first step while comparing entities is to take the unmatched root entities of a model. This means to take in the base model and the target model, all entities that have no unmatched parent (In the first iteration of this process, it means to take the root entities of the models). 

Once we have those entities, we will iterate over all the top entities from the base model, and try to find identical entities in the top entities from the target model. The process to do this will be explained in the section [Comparison logic](#comparison-logic). When we find an identical entity, we produce a `FamixUnchangedChange` for the entity. 

This step can have two outcome possible:
- We found some matches. In that case we restart this step with the new unmatched top entities from both models.
- We did not find any match, then we proceed to the second step.

During the second step, we will look for renamed entities among the top unmatched entities. Once again two outcomes are possible:
- We found some matches. In that case we restart at step 1 with the new unmatched top entities from both models and look again for identical entities.
- We did not find any match, then we proceed to the third step.

During the third step, we will look for moved entities among the top unmatched entities. Once again two outcomes are possible:
- We found some matches. In that case we restart at step 1 with the new unmatched top entities from both models and look again for identical entities.
- We did not find any match, then we proceed to the fourth step.

If we cannot find any entity that are identical, renamed or moved among the top level entities, we look for entities that might have moved among all entities of the target model because it is possible that an entity moved deeper into the hierarchy. 
If we found some we can retry the whole process on the remaining top entities. Else we can finalize the analysis. 

When we cannot find any more matching entities, we can consider that the remaining entities from the source model are removed entities, and the remaining entities from the target model are added entities.

### Comparison logic 

In order to find if some entities are identical, renamed or moved we need to compare them. In order to make those comparisons effective for all languages and to manage the different kind of entities, we need to customize those comparisons depending on the Famix traits they are using. For example FamixTNamedEntity need to take into account the name of an entity in order to compare them. When an entity is identical or moved, the name needs to be the same and for renamed entities, the name needs to be different. 

We are managing this using a pragma called `#famixDiff:priority:`. If we wish for a property to be compared between two entities, we can implement a method taking two parameters:
- The entity to compare the receiver with
- The resolver that can be helpful sometimes (we will explain later why)

This comparison method also needs to have the pragma `#famixDiff:priority:` and the first parameter will define when to use this comparison method. It should be a symbol that can be `#identity`, `#rename` or `#move`. The second parameter is just an integer used for optimization since some criteria are faster to compare (for example it's faster to compare the class of both entities compared to comparing their dependencies).

Example

```st
FamixTNamedEntity>>compareNameWith: otherEntity resolver: aResolver

	<famixDiff: #identity priority: 3>
	<famixDiff: #move priority: 3>
	^ self name = otherEntity name
```

This method on FamixTNamedEntity will be used to compare the identity of two entities or a moving of an entity.

As we were saying before, it might be useful to know also the resolver. For example, when we want to compare the parents of an entity. If a parent got renamed, we cannot just compare the name of the parents. But the resolver knows the renamed entities (and since we are comparing from top to bottom, the parents are matched before their children). 

```st
TEntityMetaLevelDependency>>compareParentsWith: otherEntity resolver: resolver

	"I check that the parents of both entities are the same."

	<famixDiff: #identity priority: 5>
	<famixDiff: #rename priority: 5>
	| baseParents targetParents |
	baseParents := self parents.
	targetParents := otherEntity parents.

	baseParents size = targetParents size ifFalse: [ ^ false ].

	baseParents do: [ :baseParent | 
		targetParents
			detect: [ :targetParent | "We delegate the comparison to the resolver because it's possible a parent is the same but got renamed. This should deal with this case." 
				resolver is: baseParent sameAs: targetParent ]
			ifNone: [ ^ false "A parent of the base entity does not have a matching parent so we escape." ] ].

	^ true
  ```

Here we see that we check that the parents are the same for the receiver and the parameter, but instead of comparing their names, we ask the resolver to compare them itself to manage renamings. 

#### Customize the comparison depending on the metamodel

If a specific metamodel has specificities that should be taken into account in the comparison, it is possible to add any comparison method on a Famix trait or directly on the concrete entities as long as they are using at least one pragma `#famixDiff:priority:`.

### Optimization logic

FamixDiff needs to apply a huge number of comparisons between entities. On a middle size project it can happen billions of times. When the comparison logic was finished, I tried to apply it on a middle size project and it took 3h to run because the algorithm was constantly collecting the pragmas in the entities to compare to apply the comparisions.

I tried to do a first optimization by saving the methods to execute (the methods with the pragmas) in a dictionary for each kind of entities in the model. Once the algorithm finished to run, I was discarding this cache. 
This method allowed to reduce the execution time from 3h to 20min but most of the time was spend in the access to the cache.

Currently, a more brutal optimization is implemented. 
I removed the cache and instead, for each kind of entities, the first comparison will call a method that does not exist in the system. FamixDiff will catch the `MessageNotUnderstood` raised and will collect the pragmas for this specific kind of entity. Once we have the methods to execute, we compile dynamically a method containing all the code to execute the comparison and we call this method. Then, for all other entities of this kind, we just execute this compiled method.

This is done like this:

```st
TEntityMetaLevelDependency>>identityMatch: otherEntity resolver: resolver
	"We consider that the entities are identical if all comparators declared for the entity with the following pragma are matching."

	"The code here is a little weird but it is for performance reasons. Each entity will apply some filters to know if they are identical or not. Those filters are implemented on different traits composing the entities and we collect them via a pragma. But it takes some time to collect them.
	In order to speed up things, the first time we get here for a specific class, we will have a message not understood and we will generate a method collecting all the filters and applying them.
	Once the computation is finished, the resolver will remove this generated code from the system."
	^ [ self isIdenticalTo: otherEntity resolver: resolver ]
		  on: MessageNotUnderstood
		  do: [
			  self generateMethodNamed: #isIdenticalTo:resolver: basedOnPragmaName: #identity.
			  self isIdenticalTo: otherEntity resolver: resolver ]
```

For example, on a java model if the kind of the entity is a `FamixJavaPackage``, it will generate a method like this:

```st
FamixJavaPackage>>isIdenticalTo: otherEntity resolver: resolver

	(self hasSameClassAs: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	(self compareNameWith: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	(self compareParentsWith: otherEntity resolver: resolver) ifFalse: [ ^ false ].
	 ^ true
```

Once the execution of the algo is finished, we are removing all this generated code. This allows the developper to not have to invalidate any cache when he will update the comparison methods.

## Diff between associations

For now the comparision of associations is pretty simple and is done by `#computeDiffBetweenAssociations`.

This method will iterate over all changes detected on entities.

If the change is a `FamixAddChange`, it will ask for its outgoing dependencies and mark them as new dependencies.

If the change is a `FamixRemovalChange`, it will ask for its outgoing dependencies and mark them as removed dependencies.

In other cases, it will compare the the associations of both versions of the entities to find which dependencies might have been added or removed using the method `FamixTAssociation>>#matches:resolver:`.