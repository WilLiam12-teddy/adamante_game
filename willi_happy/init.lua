minetest.register_craftitem("willi_happy:yogurt", {
	description = "Iogurte de Morango",
	inventory_image = "willi_yogurt.png",
	on_use = minetest.item_eat(3)
})

minetest.register_node("willi_happy:block_a", {
	description = "Brick Block",
	tiles = {"willi_brick.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1}
})


		