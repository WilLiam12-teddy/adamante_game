minetest.register_node("yay_biancatreal:nyancat", {
	description = "biancatREAL Nyan Cat",
	tiles = {"nyancat_side.png", "nyancat_side.png", "nyancat_side.png",
		"nyancat_side.png", "nyancat_back.png", "nyancat_front.png"},
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
})

minetest.register_node("yay_biancatreal:nyancat_rainbow", {
	description = "biancatREAL Nyan Cat Rainbow",
	tiles = {
		"nyancat_rainbow.png^[transformR90",
		"nyancat_rainbow.png^[transformR90",
		"nyancat_rainbow.png"
	},
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	sounds = default.node_sound_defaults(),
})


minetest.register_craft({
	type = "fuel",
	recipe = "yay_biancatreal:nyancat",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "yay_biancatreal:nyancat_rainbow",
	burntime = 1,
})