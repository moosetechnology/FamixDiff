# FamixDiff: User documentation

FamixDiff allows one to compute the diff between two Moose models representing two different versions of the same project. It will return a report containing the different kind of changes that happened between those two versions. 
To detect entities that got renamed or moved in the project, we are using some heuristics that can be parametrized (See section [Customize the analysis](#customize-the-analysis)).

- [FamixDiff: User documentation](#famixdiff-user-documentation)
  - [Launch an analysis](#launch-an-analysis)
  - [Changes](#changes)
  - [FamixDiffResult](#famixdiffresult)
  - [Customize the analysis](#customize-the-analysis)
  - [Possible evolutions](#possible-evolutions)

## Launch an analysis

Running a diff computation is as simple as:

```st
| sourceModel targetModel |
sourceModel := MooseModel root at: 1. 
targetModel := MooseModel root at: 2.

FXDiff runOnBaseModel: sourceModel targetModel: targetModel
```

This will return a `FamixDiffResult` containing changes. The different kind of changes will be explained in section [Changes](#changes) and the manipulation of the result will be explained in section [FamixDiffResult](#famixdiffresult).

## Changes

FamixDiff will produce different kind of results:
- `FamixUnchangedChange`: This change represent an entity that is present in both the source and the target model with the same name and the same parents. /!\ It does not mean that this entity had no change at all. The source code of this entity might have changed. This is not yet covered by FamixDiff.
- `FamixAddChange`: This represent an entity that is not present in the base model but present in the target model.
- `FamixRemovalChange`: This represent an entity that is present in the base model but not in the target model.
- `FamixMoveChange`: This represent an entity present in both the source and target model, but that have a different parent between both. This means that the entity is still here but has moved.
- `FamixRenameChange`: This represent an entity that is present in both the source and target model but whose name changed.

## FamixDiffResult

A diff analysis will return a `FamixDiffResult`. This class is a collection of changes. 

It is possible to act on it as on any other collection. 

For example: 

```st
result select: [ :change | change baseEntity name beginsWith: 'A' ].
```

But it also provides an API to filter the changes. Each of the methods of this API will return a new `FamixDiffResult` with a subset of the changes. Be careful, this subset does not know its superset, so you might want to keep the original result if you wish to do multiple analysis.

It is first possible to filter the changes by kind using:
- `#additions`
- `#removals`
- `#moves`
- `#renames`
- `#identities`

## Customize the analysis 

> TODO

## Possible evolutions

> TODO (updated entity)