## directly copied from StatsBase.jl to avoid the dependency ##

const RealArray{T<:Real,N} = AbstractArray{T,N}
const IntegerArray{T<:Integer,N} = AbstractArray{T,N}

function _check_randparams(rks, x, p)
    n = length(rks)
    length(x) == length(p) == n || raise_dimerror()
    return n
end

# Ordinal ranking ("1234 ranking") -- use the literal order resulted from sort
function ordinalrank!(rks::RealArray, x::RealArray, p::IntegerArray)
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

ordinalrank(x::RealArray) = ordinalrank!(Array{Int}(size(x)), x, sortperm(x))
