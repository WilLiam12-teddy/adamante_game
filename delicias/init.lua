minetest.register_tool("delicias:doritos", {
    description = "Pacote de Doritos",
    inventory_image = "doritos.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=1.60, [2]=1.20, [3]=0.80 }
            },
        },
        damage_groups = {fleshy=2},
    },
})

minetest.register_craftitem("delicias:doritos_queijo", {
    description = "Doritos",
    inventory_image = "doritos_queijo.png",
    on_use = minetest.item_eat(1),
})

minetest.register_craft({
    type = "shapeless",
    output = "delicias:doritos_queijo 18",
    recipe = {
        "delicias:doritos",
    },
})

minetest.register_craftitem("delicias:coke", {
    description = "Coca-Cola",
    inventory_image = "cocacola.png",
    on_use = minetest.item_eat(1),
})

minetest.register_craftitem("delicias:sorvete", {
    description = "Sorvete",
    inventory_image = "sorvete.png",
    on_use = minetest.item_eat(2),
})

minetest.register_craftitem("delicias:milki", {
    description = "Milk Shake",
    inventory_image = "milki.png",
    on_use = minetest.item_eat(2),
})

minetest.register_tool("delicias:cookies", {
    description = "Pacote de Cookies",
    inventory_image = "cookies.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=1.60, [2]=1.20, [3]=0.80 }
            },
        },
        damage_groups = {fleshy=2},
    },
})

minetest.register_craftitem("delicias:cookie", {
    description = "Cookie de Chocolate Delicioso",
    inventory_image = "cookie.png",
    on_use = minetest.item_eat(1),
})

minetest.register_craft({
    type = "shapeless",
    output = "delicias:cookie 10",
    recipe = {
        "delicias:cookies",
    },
})

minetest.register_craftitem("delicias:cupcake", {
    description = "Cupcake de Chocolate",
    inventory_image = "cupcake.png",
    on_use = minetest.item_eat(1),
})