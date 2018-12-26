module D3DecisionTrees

using DecisionTree, D3Trees
include("ordinalrank_copy.jl")

function name(node::Node)
    featval = string(isa(node.featval, Real) && !isa(node.featval, Bool) ? round(node.featval; digits=2) : node.featval)
    "Feature: $(string(node.featid))\nThreshold: $(featval)"
end

function name(leaf::Leaf)
    matches = findall(leaf.values .== leaf.majority)
    ratio = string(length(matches)) * "/" * string(length(leaf.values))
    majority = string(isa(leaf.majority, Real) && !isa(leaf.majority, Bool) ? round(leaf.majority; digits=2) : leaf.majority)
    "Leaf\n$(majority): $(ratio)"
end

function add_children!(model::Leaf, tree::Vector{Vector{Int}}, names::Vector{String}, ordering=Vector{Int}, indent_counter=1)
    push!(tree, Int[])
end

function add_children!(model::Node, tree::Vector{Vector{Int}}, names::Vector{String}, ordering=Vector{Int}, indent_counter=1)
    push!(tree, [1,2]) # placeholders for correct indices

    # left
    push!(names, name(model.left))
    push!(ordering, indent_counter)
    add_children!(model.left, tree, names, ordering, indent_counter+1)

    # right
    push!(names, name(model.right))
    push!(ordering, indent_counter)
    add_children!(model.right, tree, names, ordering, indent_counter+1)
end

"""
    D3DecisionTree(model::DecisionTree.Node)

Construct an interactive tree visualization from a `DecisionTree` model
to be displayed using D3 in a browser or ipython notebook.
"""
function D3DecisionTree(model::Node)
    modeltree = Vector{Vector{Int}}()
    names = [name(model)]::Vector{String}
    ordering = Int[0]

    add_children!(model, modeltree, names, ordering)

    ordering = ordinalrank(ordering)
    n = length(ordering)

    modeltreeout = Vector{Vector{Int}}(undef, n)
    namesout = Vector{String}(undef, n)

    for i=1:n
        o = ordering[i]
        modeltreeout[o] = modeltree[i]
        namesout[o] = names[i]
    end

    # fill in correct indices
    c=2
    for i=1:n
        if modeltreeout[i] != Int[]
            modeltreeout[i] = [c, c+1]
            c += 2
        end
    end

    D3Tree(modeltreeout, text=namesout)
end


export D3DecisionTree

end # module
