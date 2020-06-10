minetest.register_node("lamps:lamp", {
	description = "Lampada",
	drawtype = "glasslike",
	tiles = {"tex_light.png"},
	inventory_image = minetest.inventorycube("tex_light.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	--sounds = default.node_sound_glass_defaults(),
	--sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = 'lamps:lamp',
	recipe = {
		{"default:glass"	,"default:glass"	,"default:glass"},
		{"default:glass"	,"default:torch"	,"default:glass"},
		{"default:glass"	,"default:glass"	,"default:glass"},
		--COMENTaRIO: dye:dark_green = dye:blue[B2] + dye:yellow[C2]
	}
})

minetest.register_alias("lâmpada"	,"lamps:lamp")
minetest.register_alias("lampada"	,"lamps:lamp")

