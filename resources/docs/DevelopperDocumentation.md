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
- We did not find any match

TODO

### Comparison logic 

> TODO

#### Customize the comparison depending on the metamodel

> TODO

### Optimization logic

> TODO

## Diff between associations

> TODO