using GroupOptim
using Test


function test_mdvrp()

    ncities = 15
    ndepots = 3
    cities = 1:ncities

    xy = 100rand(ncities, 2)

    distances = [sum(abs.(a - b)) for a in eachrow(xy), b in eachrow(xy)]

    depots = Groups(ndepots, cities, ordered=true)
    # insert cities using method

    #set_capacity_func!(g, items -> length(items))
    #set_items!(g, items)

end


test_mdvrp()

@test true
