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

	register_pane("framed_coloured_glass:clear", {
		description = "Clear Framed Glass Pane",
		textures = {"coloured_glass_clear_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png","coloured_glass_pane_top.png","coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_clear_framed.png",
		inventory_image = "coloured_glass_clear_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"default:glass", "default:glass", "",},
			{"default:steel_ingot", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:black", {
		description = "Black Framed Glass Pane",
		textures = {"coloured_glass_black_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png","coloured_glass_pane_top.png","coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_black_framed.png",
		inventory_image = "coloured_glass_black_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:black", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:blue", {
		description = "Blue Framed Glass Pane",
		textures = {"coloured_glass_blue_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png","coloured_glass_pane_top.png","coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_blue_framed.png",
		inventory_image = "coloured_glass_blue_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:blue", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:brown", {
		description = "Brown Framed Glass Pane",
		textures = {"coloured_glass_brown_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_brown_framed.png",
		inventory_image = "coloured_glass_brown_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:brown", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:cyan", {
		description = "Cyan Framed Glass Pane",
		textures = {"coloured_glass_cyan_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_cyan_framed.png",
		inventory_image = "coloured_glass_cyan_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:cyan", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:grey", {
		description = "Grey Framed Glass Pane",
		textures = {"coloured_glass_grey_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_grey_framed.png",
		inventory_image = "coloured_glass_grey_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:grey", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:green", {
		description = "Green Framed Glass Pane",
		textures = {"coloured_glass_green_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_green_framed.png",
		inventory_image = "coloured_glass_green_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:green", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:light_blue", {
		description = "Light Blue Framed Glass Pane",
		textures = {"coloured_glass_light_blue_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_light_blue_framed.png",
		inventory_image = "coloured_glass_light_blue_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:light_blue", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:lime", {
		description = "Lime Framed Glass Pane",
		textures = {"coloured_glass_lime_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_lime_framed.png",
		inventory_image = "coloured_glass_lime_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:lime", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:magenta", {
		description = "Magenta Framed Glass Pane",
		textures = {"coloured_glass_magenta_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_magenta_framed.png",
		inventory_image = "coloured_glass_magenta_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:magenta", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:orange", {
		description = "Orange Framed Glass Pane",
		textures = {"coloured_glass_orange_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_orange_framed.png",
		inventory_image = "coloured_glass_orange_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:orange", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:pink", {
		description = "Pink Framed Glass Pane",
		textures = {"coloured_glass_pink_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_pink_framed.png",
		inventory_image = "coloured_glass_pink_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:pink", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:purple", {
		description = "Purple Framed Glass Pane",
		textures = {"coloured_glass_purple_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_purple_framed.png",
		inventory_image = "coloured_glass_purple_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:purple", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:red", {
		description = "Red Framed Glass Pane",
		textures = {"coloured_glass_red_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_red_framed.png",
		inventory_image = "coloured_glass_red_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:red", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:silver", {
		description = "Silver Framed Glass Pane",
		textures = {"coloured_glass_silver_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_silver_framed.png",
		inventory_image = "coloured_glass_silver_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:silver", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:white", {
		description = "White Framed Glass Pane",
		textures = {"coloured_glass_white_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_white_framed.png",
		inventory_image = "coloured_glass_white_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:white", "", "",},
			{"","","",},
		}
})
register_pane("framed_coloured_glass:yellow", {
		description = "Yellow Framed Glass Pane",
		textures = {"coloured_glass_yellow_framed.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png", "coloured_glass_pane_top.png"},
		groups = {cracky = 3, oddly_breakable_by_hand=3},
		use_texture_alpha = true,
		wield_image = "coloured_glass_yellow_framed.png",
		inventory_image = "coloured_glass_yellow_framed.png",
		sounds = default.node_sound_glass_defaults(),
		recipe = {
			{"xpanes:framed_coloured_glass:clear_flat", "", "",},
			{"dye:yellow", "", "",},
			{"","","",},
		}
})
