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

minetest.register_node("adamante_food:cocacola", {
	description = ("Coca-Cola"),
	drawtype = "plantlike",
	tiles = {"cocacola.png"},
	inventory_image = "cocacola.png",
	wield_image = "cocacola.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
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

minetest.register_node("adamante_food:doritos", {
	description = ("Pacote de Doritos"),
	drawtype = "plantlike",
	tiles = {"doritos.png"},
	inventory_image = "doritos.png",
	wield_image = "doritos.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})

minetest.register_node("adamante_food:snackmachine2", {
	description = ("Maquina de Doces e Snacks 2"),
  drawtype = "mesh",
	mesh = "snack_machine.obj",
  inventory_image = "snack_machine2_inv.png",
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 15,
  tiles = {"snack_machine2.png"},
  groups = {snappy=3},
})