abstract type AbsGroup end

mutable struct Groups{T} <: AbsGroup
    groups::Vector{Int}
    items::Array{T}
    constraints::Vector{Float64}
end


function Groups(ngroups::Integer, items::AbstractArray; insertion=PushInsertion(), deletion=PopDeletion())
    @assert size < length(items) "The number of items must be greater than the number of groups."

    groups = sparse(zeros(Bool, size, length(items)))
    constraints = zeros(0)

    Groups(groups, items, constraints)
end

Base.getindex(g::Groups, i::Int) = findall(g.groups[i,:])


function Base.insert!(g::Groups, index::Integer, item)
    g.groups[index, item] = true
end
