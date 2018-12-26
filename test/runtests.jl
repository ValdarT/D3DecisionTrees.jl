using D3DecisionTrees, DecisionTree, D3Trees
using Test, Random

# classification tree
m, n = 10^2, 5

tf = [trues(Int(m/2)) falses(Int(m/2))]
inds = randperm(m)
labels = string.(tf[inds])

features = Array{Any}(undef, m, n)
features[:,:] = randn(m, n)
features[:,2] = string.(tf[randperm(m)])
features[:,3] = round.(Int, features[:,3])
features[:,4] = tf[inds]

model = build_tree(labels, features)

@test typeof(D3DecisionTree(model)) == D3Trees.D3Tree


# regression tree
n,m = 10^3, 5
features = randn(n,m)
weights = rand(-2:2,m)
labels = features * weights

model = build_tree(labels, features)

@test typeof(D3DecisionTree(model)) == D3Trees.D3Tree
