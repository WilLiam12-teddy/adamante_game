minetest.register_craftitem("willi_food:yogurt", {
	description = "Iogurte de Morango",
	inventory_image = "willi_yogurt.png",
	on_use = minetest.item_eat(3)
})