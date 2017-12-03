# D3DecisionTrees

Uses [D3Trees.jl](https://github.com/sisl/D3Trees.jl) to create an interactive visualization of a decision tree model trained with [DecisionTree.jl](https://github.com/bensadeghi/DecisionTree.jl).

This is a **MWE**, not something actually useful (yet).

## Installation

This is not a registered package. To install it from this GitHub page, run:

```julia
Pkg.clone("https://github.com/ValdarT/D3DecisionTrees.jl.git")
```

## Usage example with random data

```julia
# random data
n,m = 10^3, 5;
features = randn(n,m);
weights = rand(-2:2,m);
labels = features * weights;

# build a regression model
model = build_tree(labels, features, 5, 0, 5);

# create the D3Tree of the model
t = D3DecisionTree(model)

# show in Chrome browser
inchrome(t)
```

**Note**: D3Trees.jl currently requires internet connection to work.