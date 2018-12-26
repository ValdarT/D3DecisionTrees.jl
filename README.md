# D3DecisionTrees

[![Build status](https://ci.appveyor.com/api/projects/status/mfuu09d9ql04qt5x/branch/master?svg=true)](https://ci.appveyor.com/project/ValdarT/d3decisiontrees-jl/branch/master)
[![Build Status](https://travis-ci.org/ValdarT/D3DecisionTrees.jl.svg?branch=master)](https://travis-ci.org/ValdarT/D3DecisionTrees.jl)
[![Coverage Status](https://coveralls.io/repos/github/ValdarT/D3DecisionTrees.jl/badge.svg?branch=master)](https://coveralls.io/github/ValdarT/D3DecisionTrees.jl?branch=master)
[![codecov](https://codecov.io/gh/ValdarT/D3DecisionTrees.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/ValdarT/D3DecisionTrees.jl)

Uses [D3Trees.jl](https://github.com/sisl/D3Trees.jl) to create an interactive visualization of a decision tree model trained with [DecisionTree.jl](https://github.com/bensadeghi/DecisionTree.jl).

## Installation

This is not a registered package. To install it from this GitHub page, run:

```julia
] add https://github.com/ValdarT/D3DecisionTrees.jl
```

## Usage example

```julia
using DecisionTree, D3DecisionTrees

# Fisher's Iris dataset as features and labels
features, labels = load_data("iris")

# build a classification model
model = build_tree(labels, features)

# create the D3Tree of the model
t = D3DecisionTree(model)

# show in Chrome browser
inchrome(t)
```

**Note**: D3Trees.jl currently requires internet connection to work.
