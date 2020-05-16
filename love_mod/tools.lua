minetest.register_tool("love_mod:wand", {
	description = "Love Wand",
	inventory_image = "love_mod_wand.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		damage_groups = {fleshy= -10},
		groupcaps={},
	}
})