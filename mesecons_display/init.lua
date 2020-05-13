local function morelightstones_add(name, base_item, texture_off, texture_on)
	minetest.register_node(":mesecons_lightstone:lightstone_hc_" .. name .. "_off", {
		tiles = {texture_off},
		groups = {cracky=2, mesecon_effector_off = 1, mesecon = 2},
		description="High Contrast "..name.." Lightstone",
		sounds = default.node_sound_stone_defaults(),
		mesecons = {effector = {
			rules = lightstone_rules,
			action_on = function (pos, node)
				minetest.swap_node(pos, {name = "mesecons_lightstone:lightstone_hc_" .. name .. "_on", param2 = node.param2})
			end,
		}}
	})
	minetest.register_node(":mesecons_lightstone:lightstone_hc_" .. name .. "_on", {
	tiles = {texture_on},
	groups = {cracky=2,not_in_creative_inventory=1, mesecon = 2},
	drop = "mesecons_lightstone:lightstone_hc_" .. name .. "_off",
	light_source = default.LIGHT_MAX-2,
	sounds = default.node_sound_stone_defaults(),
	mesecons = {effector = {
		rules = lightstone_rules,
		action_off = function (pos, node)
			minetest.swap_node(pos, {name = "mesecons_lightstone:lightstone_hc_" .. name .. "_off", param2 = node.param2})
		end,
	}}
	})

	minetest.register_craft({
		output = "mesecons_lightstone:lightstone_hc_" .. name .. "_off",
		recipe = {
			{"",base_item,""},
			{base_item,"mesecons_lamp:lamp_off",base_item},
			{"","group:mesecon_conductor_craftable",""}
		}
	})
end

morelightstones_add("red", "dye:red", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_red_on.png")
morelightstones_add("green", "dye:green", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_green_on.png")
morelightstones_add("blue", "dye:blue", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_blue_on.png")
morelightstones_add("gray", "dye:grey", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_gray_on.png")
morelightstones_add("yellow", "dye:yellow", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_yellow_on.png")
morelightstones_add("cyan", "dye:cyan", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_cyan_on.png")
morelightstones_add("magenta", "dye:magenta", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_magenta_on.png")
morelightstones_add("orange", "dye:orange", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_orange_on.png")
morelightstones_add("pink", "dye:pink", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_pink_on.png")
morelightstones_add("violet", "dye:violet", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_violet_on.png")
morelightstones_add("white", "dye:white", "jeija_lightstone_darkgray_off.png", "jeija_lightstone_white_on.png")
