module GroupOptim
import Random

abstract type AbsGroup end

struct PushInsertion end
struct PopDeletion end


Base.@kwdef struct Group <: AbsGroup
    items::Vector{Int} = zeros(Int,0)
    constraints::Vector{Float64} = zeros(0)
    any_order::Bool = false 
    feasible::Bool = true
    capacity::Float64 = 0.0
    maxcapacity::Float64 = Inf
end

function Group(items)
    Group(;items)
end

function Base.in(item, g::AbsGroup)
    item in g.items
end

function set_capacity_func!(g::AbsGroup, f::Function)
    g.capacity_func = f
    g.capacity = f(g.items)
end

function isfull(g::AbsGroup)
    g.capacity >= g.maxcapacity
end

Base.@kwdef struct RandomInsertion{T}
    rng::T = Random.default_rng()
end

Base.@kwdef struct RandomDeletion{T}
    rng::T = Random.default_rng()
end



function insertion!(group::AbsGroup, insertion::RandomInsertion, item)
    if isfull(group)
        error("Not enough capacity.")
    end
    
    index = rand(insertion.rng, eachindex(group))
    insert!(group.items, index, item)
end

function insertion!(group::AbsGroup, insertion::PushInsertion, item)
    if isfull(group)
        error("Not enough capacity.")
    end
    
    push!(group.items, item)
end


function deletion!(group::AbsGroup, deletion::RandomDeletion)
    index = rand(deletion.rng, eachindex(group))
    deleteat!(g.items, index, item)
end
##################################################
##################################################
##################################################
struct Groups{T <: AbsGroup, I}
    groups::Array{T}
    items::I
    ordered::Bool
    order_func::Function
    insertion
    deletion
end

function Groups(size::Integer, items::AbstractArray;
        maxcapacity = Inf,
        ordered=true, order_func=v->0, insertion=PushInsertion(), deletion=PopDeletion())
    @assert size < length(items) "The number of groups must be greater than the number of elements."
    groups = [Group(;maxcapacity) for i in 1:size]

    # if !ordered
    #     items = Set(tems)
    # end
    
    Groups(groups, items, ordered, order_func, insertion, deletion)
end


Base.getindex(g::Groups, i::Int) = g.groups[i]

function Base.insert!(g::Groups, index::Integer, item)
    insertion!(g[index], g.insertion, item)
end


export Group, Groups

end # module GroupOptim
