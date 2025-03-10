# FamixDiff
Computes the list of changes (add/delete/move/rename) between two versions of the same system (in two models)

## Installation

To install the project in your Pharo image execute:

```Smalltalk
    Metacello new
    	githubUser: 'moosetechnology' project: 'FamixDiff' commitish: 'master' path: 'src';
    	baseline: 'FamixDiff';
    	load
```

To add it to your baseline:

```Smalltalk
    spec
    	baseline: 'FamixDiff'
    	with: [ spec repository: 'github://moosetechnology/FamixDiff:master/src' ]
```

Note that you can replace the #master by another branch such as #development or a tag such as #v1.0.0, #v1.? or #v1.1.?.

## Documentation 

Full documentation available at:
- [User documentation](resources/docs/UserDocumentation.md)
- [Developper documentation](resources/docs/DevelopperDocumentation.md)

### Quick Start

Running a diff computation is as simple as:

```st
| sourceModel targetModel |
sourceModel := MooseModel root at: 1.
targetModel := MooseModel root at: 2

FXDiff runOnBaseModel: sourceModel targetModel: targetModel.
```

This will return a `FamixDiffResult` containing changes.

See documentations above for more info.