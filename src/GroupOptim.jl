module GroupOptim

abstract type AbsGroup end

Base.@kwdef struct Group <: AbsGroup
    items::Vector{Int} = zeros(Int,0)
    constraints::Vector{Float64} = zeros(0)
    capacity::Float64 = 0.0
    capacity::Float64 = Inf
    any_order::Bool = false 
    feasible::Bool = true
end

function Group(items)
    Group(;items)
end

function firstfit!(g::Group, items)
    
end


function Base.insert!(g::AbsGroup, item)
    push!(g.items, item)
end

function Base.in(item, g::AbsGroup)
    item in g.items
end

function set_capacity_func!(g::AbsGroup, f::Function)
    g.capacity_func = f
    g.capacity = f(g.items)
end

function isfull(g::AbsGroup)
    g.capacity <= g.capacity_limit
end



export Group

end # module GroupOptim
