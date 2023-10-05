using GroupOptim
using Test


function test_js()

    tasks = "task_" .* string.(1:100)
    costs = rand(1:100, 100)

    items = tasks .=> costs

    println(items)

    g = Group()

    set_capacity_func!(g, items -> length(items))
    set_items!(g, items)

end




@test true
