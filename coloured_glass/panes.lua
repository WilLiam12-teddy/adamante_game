function register_pane(name, def)
	for i = 1, 15 do
		minetest.register_alias("xpanes:" .. name .. "_" .. i, "xpanes:" .. name .. "_flat")
	end

	local flatgroups = table.copy(def.groups)
	flatgroups.pane = 1
	minetest.register_node(":xpanes:" .. name .. "_flat", {
		description = def.description,
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		paramtype2 = "facedir",
		use_texture_alpha = true,
		tiles = {def.textures[3], def.textures[3], def.textures[1]},
		groups = flatgroups,
		drop = "xpanes:" .. name .. "_flat",
		sounds = def.sounds,
		node_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		selection_box = {
			type = "fixed",
			fixed = {{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connect_sides = { "left", "right" },
	})

	local groups = table.copy(def.groups)
	groups.pane = 1
	groups.not_in_creative_inventory = 1
	minetest.register_node(":xpanes:" .. name, {
		drawtype = "nodebox",
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = true,
		use_texture_alpha = true,
		description = def.description,
		tiles = {def.textures[3], def.textures[3], def.textures[1]},
		groups = groups,
		drop = "xpanes:" .. name .. "_flat",
		sounds = def.sounds,
		node_box = {
			type = "connected",
			fixed = {{-1/32, -1/2, -1/32, 1/32, 1/2, 1/32}},
			connect_front = {{-1/32, -1/2, -1/2, 1/32, 1/2, -1/32}},
			connect_left = {{-1/2, -1/2, -1/32, -1/32, 1/2, 1/32}},
			connect_back = {{-1/32, -1/2, 1/32, 1/32, 1/2, 1/2}},
			connect_right = {{1/32, -1/2, -1/32, 1/2, 1/2, 1/32}},
		},
		connects_to = {"group:pane", "group:stone", "group:glass", "group:wood", "group:tree"},
	})

	minetest.register_craft({
		output = "xpanes:" .. name .. "_flat 16",
		recipe = def.recipe
	})
end

register_pane("coloured_glass:black", {
		description = "Black Glass Pane",
		textures = {"coloured_glass_black.png", "coloured_glass_black.png", "coloured_glass_black.png","coloured_glass_black.png","coloured_glass_black.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_black.png",
		inventory_image = "coloured_glass_black.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:black", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:blue", {
		description = "Blue Glass Pane",
		textures = {"coloured_glass_blue.png", "coloured_glass_blue.png", "coloured_glass_blue.png","coloured_glass_blue.png","coloured_glass_blue.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_blue.png",
		inventory_image = "coloured_glass_blue.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:blue", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:brown", {
		description = "Brown Glass Pane",
		textures = {"coloured_glass_brown.png", "coloured_glass_brown.png", "coloured_glass_brown.png", "coloured_glass_brown.png", "coloured_glass_brown.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_brown.png",
		inventory_image = "coloured_glass_brown.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:brown", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:cyan", {
		description = "Cyan Glass Pane",
		textures = {"coloured_glass_cyan.png", "coloured_glass_cyan.png", "coloured_glass_cyan.png", "coloured_glass_cyan.png", "coloured_glass_cyan.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_cyan.png",
		inventory_image = "coloured_glass_cyan.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:cyan", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:grey", {
		description = "Grey Glass Pane",
		textures = {"coloured_glass_grey.png", "coloured_glass_grey.png", "coloured_glass_grey.png", "coloured_glass_grey.png", "coloured_glass_grey.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_grey.png",
		inventory_image = "coloured_glass_grey.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:grey", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:green", {
		description = "Green Glass Pane",
		textures = {"coloured_glass_green.png", "coloured_glass_green.png", "coloured_glass_green.png", "coloured_glass_green.png", "coloured_glass_green.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_green.png",
		inventory_image = "coloured_glass_green.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:green", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:light_blue", {
		description = "Light Blue Glass Pane",
		textures = {"coloured_glass_light_blue.png", "coloured_glass_light_blue.png", "coloured_glass_light_blue.png", "coloured_glass_light_blue.png", "coloured_glass_light_blue.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_light_blue.png",
		inventory_image = "coloured_glass_light_blue.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:light_blue", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:lime", {
		description = "Lime Glass Pane",
		textures = {"coloured_glass_lime.png", "coloured_glass_lime.png", "coloured_glass_lime.png", "coloured_glass_lime.png", "coloured_glass_lime.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_lime.png",
		inventory_image = "coloured_glass_lime.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:lime", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:magenta", {
		description = "Magenta Glass Pane",
		textures = {"coloured_glass_magenta.png", "coloured_glass_magenta.png", "coloured_glass_magenta.png", "coloured_glass_magenta.png", "coloured_glass_magenta.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_magenta.png",
		inventory_image = "coloured_glass_magenta.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:magenta", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:orange", {
		description = "Orange Glass Pane",
		textures = {"coloured_glass_orange.png", "coloured_glass_orange.png", "coloured_glass_orange.png", "coloured_glass_orange.png", "coloured_glass_orange.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_orange.png",
		inventory_image = "coloured_glass_orange.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:orange", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:pink", {
		description = "Pink Glass Pane",
		textures = {"coloured_glass_pink.png", "coloured_glass_pink.png", "coloured_glass_pink.png", "coloured_glass_pink.png", "coloured_glass_pink.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_pink.png",
		inventory_image = "coloured_glass_pink.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:pink", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:purple", {
		description = "Purple Glass Pane",
		textures = {"coloured_glass_purple.png", "coloured_glass_purple.png", "coloured_glass_purple.png", "coloured_glass_purple.png", "coloured_glass_purple.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_purple.png",
		inventory_image = "coloured_glass_purple.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:purple", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:red", {
		description = "Red Glass Pane",
		textures = {"coloured_glass_red.png", "coloured_glass_red.png", "coloured_glass_red.png", "coloured_glass_red.png", "coloured_glass_red.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_red.png",
		inventory_image = "coloured_glass_red.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:red", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:silver", {
		description = "SilverGlass Pane",
		textures = {"coloured_glass_silver.png", "coloured_glass_silver.png", "coloured_glass_silver.png", "coloured_glass_silver.png", "coloured_glass_silver.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_silver.png",
		inventory_image = "coloured_glass_silver.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:silver", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:white", {
		description = "White Glass Pane",
		textures = {"coloured_glass_white.png", "coloured_glass_white.png", "coloured_glass_white.png", "coloured_glass_white.png", "coloured_glass_white.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_white.png",
		inventory_image = "coloured_glass_white.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:white", "", "",},
			{"","","",},
		}
})
register_pane("coloured_glass:yellow", {
		description = "Yellow Glass Pane",
		textures = {"coloured_glass_yellow.png", "coloured_glass_yellow.png", "coloured_glass_yellow.png", "coloured_glass_yellow.png", "coloured_glass_yellow.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_yellow.png",
		inventory_image = "coloured_glass_yellow.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:pane_flat", "", "",},
			{"dye:yellow", "", "",},
			{"","","",},
		}
})
