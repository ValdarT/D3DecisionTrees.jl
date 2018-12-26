## directly copied from StatsBase.jl to avoid the dependency ##

const RealArray{T<:Real,N} = AbstractArray{T,N}
const IntegerArray{T<:Integer,N} = AbstractArray{T,N}


function _check_randparams(rks, x, p)
    n = length(rks)
    length(x) == length(p) == n || raise_dimerror()
    return n
end



# Ordinal ranking ("1234 ranking") -- use the literal order resulted from sort
function ordinalrank!(rks::AbstractArray, x::AbstractArray, p::IntegerArray)
    n = _check_randparams(rks, x, p)

    if n > 0
        i = 1
        while i <= n
            rks[p[i]] = i
            i += 1
        end
    end

    return rks
end


"""
    ordinalrank(x; lt = isless, rev::Bool = false)

Return the [ordinal ranking](https://en.wikipedia.org/wiki/Ranking#Ordinal_ranking_.28.221234.22_ranking.29)
("1234" ranking) of an array. The `lt` keyword allows providing a custom "less
than" function; use `rev=true` to reverse the sorting order.
All items in `x` are given distinct, successive ranks based on their
position in `sort(x; lt = lt, rev = rev)`.
Missing values are assigned rank `missing`.
"""
ordinalrank(x::AbstractArray; lt = isless, rev::Bool = false) =
    ordinalrank!(Array{Int}(undef, size(x)), x, sortperm(x; lt = lt, rev = rev))
