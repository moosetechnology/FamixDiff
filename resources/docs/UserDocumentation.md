# FamixDiff: User Documentation

FamixDiff allows you to compute the difference between two Moose models representing two different versions of the same project. It returns a report containing the different types of changes that occurred between those two versions.
To detect entities that have been renamed or moved in the project, we use heuristics that can be parameterized (see section [Customize the Analysis](#customize-the-analysis)).

- [FamixDiff: User Documentation](#famixdiff-user-documentation)
  - [Launch an Analysis](#launch-an-analysis)
  - [Changes](#changes)
  - [FamixDiffResult](#famixdiffresult)
  - [Customize the Analysis](#customize-the-analysis)
  - [Possible Evolutions](#possible-evolutions)

## Launch an Analysis

Running a diff computation is as simple as:

```st
| sourceModel targetModel |
sourceModel := MooseModel root at: 1.
targetModel := MooseModel root at: 2

FXDiff runOnBaseModel: sourceModel targetModel: targetModel.
```

This will return a `FamixDiffResult` containing changes. The different types of changes are explained in the section [Changes](#changes), and the manipulation of the result is explained in the section [FamixDiffResult](#famixdiffresult).

## Changes

FamixDiff produces different types of results:
- `FamixUnchangedChange`: This change represents an entity that is present in both the source and target models with the same name and the same parent. /!\ This does not mean that this entity has not changed at all. Its source code might have changed, but this is not yet covered by FamixDiff.
- `FamixAddChange`: This represents an entity that is not present in the base model but is present in the target model.
- `FamixRemovalChange`: This represents an entity that is present in the base model but not in the target model.
- `FamixMoveChange`: This represents an entity present in both the source and target models but with a different parent in each. This means that the entity is still present but has moved.
- `FamixRenameChange`: This represents an entity that is present in both the source and target models but has a different name.

## FamixDiffResult

A diff analysis returns a `FamixDiffResult`, which is a collection of changes.

It can be manipulated like any other collection.

For example:

```st
result select: [ :change | change baseEntity name beginsWith: 'A' ]
```

However, it also provides an API to filter the changes. Each method in this API returns a new `FamixDiffResult` containing a subset of the changes. Be careful: this subset does not retain a reference to its superset, so you may want to keep the original result if you wish to perform multiple analyses.

It is possible to filter changes by type using:
- `#additions`
- `#removals`
- `#moves`
- `#renames`
- `#identities`

Additional filtering options include:
- `#entityChanges`: Returns only changes related to entities, excluding dependencies.
- `#associationChanges`: Returns only changes related to associations (dependencies), excluding entities.
- `#groupAdditionsAndRemovalsByRoots`: Removes additions and removals that are contained within another addition or removal. For example, if a version adds a package containing classes that contain methods, only the change representing the package addition is retained, not the additions of the classes and methods.
- `#realChanges`: Filters out unchanged changes. Most of the time, diff analysis focuses on modified entities. This method allows you to concentrate on those and ignore entities that did not change.
- `#withoutStubs`: Filters out stub entities.

Example:

```st
result realChanges entityChanges withoutStub groupAdditionsAndRemovalsByRoots.
```

This returns a result without stubs, without dependency changes, without `unchanged` changes, and containing only the root additions and removals.

## Customize the Analysis

To detect entities that have been renamed or moved, we compare their content and dependencies. For example, in the case of a Pharo class, we compare variables, methods, incoming dependencies, and outgoing dependencies to determine whether two classes are the same but renamed or moved. However, renaming or moving a class often involves additional modifications, meaning that children and dependencies may change slightly. To account for this, we allow an error margin using a tolerance ratio.

By default, this tolerance is set to 0.2. This means that if at least 80% of the children and dependencies remain the same, we consider the entity to be the same and only renamed or moved.

This ratio can be adjusted:

```st
(FXDiff baseModel: sourceModel targetModel: targetModel)
    tolerance: 0.4;
    run
```

With this snippet, we allow 40% of changed children and dependencies.

Another customization is about comments. By default FamixDiff does not check comments but it is possible to add this with #considerComments:

```Smalltalk
	(FXDiff baseModel: commonsCollections30 targetModel: commonscollections31)
		considerComments;
		run 
```

Comments cannot be moved or renamed but they can be unchanged, added or removed.

Note that this might slow down the analysis quite a lot since it takes time to compare the sources.

## Possible Evolutions

Some possible future developments for the project include:
- Detecting internal changes to entities that are not related to renaming, moving, addition, or removal (e.g., changes in source code).

