minetest.register_tool("adamante_food:doritos", {
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

minetest.register_craftitem("adamante_food:doritos_queijo", {
    description = "Doritos",
    inventory_image = "doritos_queijo.png",
    on_use = minetest.item_eat(1),
})

minetest.register_craft({
    type = "shapeless",
    output = "adamante_food:doritos_queijo 18",
    recipe = {
        "delicias:doritos",
    },
})

minetest.register_craftitem("adamante_food:coke", {
    description = "Coca-Cola",
    inventory_image = "cocacola.png",
    on_use = minetest.item_eat(1),
})

minetest.register_craftitem("adamante_food:sorvete", {
    description = "Sorvete",
    inventory_image = "sorvete.png",
    on_use = minetest.item_eat(2),
})

minetest.register_craftitem("adamante_food:milki", {
    description = "Milk Shake",
    inventory_image = "milki.png",
    on_use = minetest.item_eat(2),
})

minetest.register_craftitem("adamante_food:cookie", {
		description = "Biscoito (cookie)",
		on_use = minetest.item_eat(2),
		groups={food=3,crumbly=3},
		walkable = false,
		sunlight_propagates = true,
                inventory_image = "cookie.png",
		drawtype="nodebox",
		paramtype = "light",
		node_box = cookies_box
})

minetest.register_craftitem("adamante_food:cupcake", {
    description = "Cupcake de Chocolate",
    inventory_image = "cupcake.png",
    on_use = minetest.item_eat(1),
})

minetest.register_node("adamante_food:snackmachine", {
	description = ("Maquina de Doces"),
  drawtype = "mesh",
	mesh = "snack_machine.obj",
  inventory_image = "snack_machine_inv.png",
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 15,
  tiles = {"snack_machine.png"},
  groups = {snappy=3},
})