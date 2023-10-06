abstract type AbsGroup end

mutable struct Groups{T, I} <: AbsGroup
    groups::I
    items::Array{T}
    constraints::Vector{Float64}
    ordered::Bool
    repeated::Bool
end


function Groups(ngroups::Integer, items::AbstractArray; insertion=PushInsertion(), deletion=PopDeletion(), ordered=true)
    @assert size < length(items) "The number of items must be greater than the number of groups."

    if ordered
        groups = sparse(zeros(Int, size, length(items)))
    else
        groups = sparse(zeros(Bool, size, length(items)))
    end
    
    constraints = zeros(0)

    Groups(groups, items, constraints, ordered, repeated)
end

Base.getindex(g::Groups, i::Int) = findall(g.groups[i,:])

function Base.insert!(g::Groups, index::Integer, item)
    if g.ordered
        g.groups[index, item] = count(g.groups[index, :] .> 0)
        return
    end
    g.groups[index, item] = true
end


