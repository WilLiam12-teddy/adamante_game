minetest.register_craftitem("willi_food:chocolate", {
	description = "Mega Chocolate",
	inventory_image = "willi_megachoco.png",
	on_use = minetest.item_eat(26)
})

minetest.register_craft({
	output = "willi_food:chocolate 99",
	recipe = {
		{"food:chocolate", "", ""},
		{"default:diamond", "food:chocolate", ""},
		{"food:chocolate", "food:chocolate",  ""}
	}
})

		