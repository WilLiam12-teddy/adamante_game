-- GENERATED CODE
-- Node Box Editor, version 0.6.4 - Stone
-- Namespace: test

minetest.register_node("love_mod:heart", {
	description = "Heart",
    tiles = {"love_mod_heart.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 1,
	sunlight_propagates = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3,tree=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.4375, 0.0625, 0.3125, 0.4375}, -- NodeBox1
			{-0.1875, -0.4375, -0.4375, 0.1875, 0.25, 0.4375}, -- NodeBox2
			{-0.25, -0.375, -0.4375, 0.25, 0.25, 0.4375}, -- NodeBox3
			{-0.3125, -0.3125, -0.4375, 0.3125, 0.25, 0.4375}, -- NodeBox4
			{-0.375, -0.25, -0.4375, 0.375, 0.25, 0.4375}, -- NodeBox5
			{-0.4375, -0.1875, -0.4375, 0.4375, 0.25, 0.4375}, -- NodeBox6
			{-0.5, -0.0625, -0.4375, 0.5, 0.25, 0.4375}, -- NodeBox7
			{-0.4375, 0.25, -0.4375, -0.0625, 0.375, 0.4375}, -- NodeBox8
			{0.0625, 0.25, -0.4375, 0.4375, 0.375, 0.4375}, -- NodeBox9
			{-0.375, 0.375, -0.4375, -0.125, 0.4375, 0.4375}, -- NodeBox10
			{0.125, 0.375, -0.4375, 0.375, 0.4375, 0.4375}, -- NodeBox11
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0.5,0.4375,0.4375,-0.5,-0.5,-0.4375},
	},
})

minetest.register_node("love_mod:heart_wall", {
	description = "Wall Heart",
    tiles = {"love_mod_heart.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 1,
	sunlight_propagates = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3,tree=1},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, 0.4375, 0.0625, 0.3125, 0.5}, -- NodeBox1
			{-0.1875, -0.4375, 0.4375, 0.1875, 0.25, 0.5}, -- NodeBox2
			{-0.25, -0.375, 0.4375, 0.25, 0.25, 0.5}, -- NodeBox3
			{-0.3125, -0.3125, 0.4375, 0.3125, 0.25, 0.5}, -- NodeBox4
			{-0.375, -0.25, 0.4375, 0.375, 0.25, 0.5}, -- NodeBox5
			{-0.4375, -0.1875, 0.4375, 0.4375, 0.25, 0.5}, -- NodeBox6
			{-0.5, -0.0625, 0.4375, 0.5, 0.25, 0.5}, -- NodeBox7
			{-0.4375, 0.25, 0.4375, -0.0625, 0.375, 0.5}, -- NodeBox8
			{0.0625, 0.25, 0.4375, 0.4375, 0.375, 0.5}, -- NodeBox9
			{-0.375, 0.375, 0.4375, -0.125, 0.4375, 0.5}, -- NodeBox10
			{0.125, 0.375, 0.4375, 0.375, 0.4375, 0.5}, -- NodeBox11
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0.5,0.5,0.4375,-0.5,-0.5,0.5},
	},
})

minetest.register_node("love_mod:sapling", {
	description = "Love Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"love_mod_sapling.png"},
	inventory_image = "love_mod_hearts.png^love_mod_sapling.png",
	wield_image = "love_mod_sapling.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.45, -0.75, -0.45, 0.45, 0.525, 0.45}
	},
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("love_mod:heart_food", {
	description = "Yummy Heart",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"love_mod_hearts.png"},
	inventory_image = "love_mod_hearts.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1},
	on_use = minetest.item_eat(3),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="love_mod:sapling", param2=1})
		else 
			minetest.set_node(pos, {name="love_mod:heart_food", param2=1})
		end
	end,
})

minetest.register_node("love_mod:leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1, not_in_creative_inventory=1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'love_mod:sapling'},
				rarity = 30,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("love_mod:jungleleaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_jungleleaves.png"},
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1, not_in_creative_inventory=1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'love_mod:sapling'},
				rarity = 30,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("love_mod:glass", {
	description = "Love Glass",
	drawtype = "glasslike_framed",
	tiles = {"default_obsidian_glass.png", "love_mod_glass.png"},
	paramtype = "light",
	light_source = 1,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("love_mod:tree_heart", {
	description = "Tree With Heart",
	tiles = {"love_mod_tree_top.png", "love_mod_tree_top.png", "love_mod_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 99,
	on_place = minetest.rotate_node

})

minetest.register_node("love_mod:tree", {
	description = "Tree",
	tiles = {"love_mod_tree_top.png", "love_mod_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	stack_max = 99,
	on_place = minetest.rotate_node

})

minetest.register_node("love_mod:wood", {
	description = "Wooden Planks",
	tiles = {"love_mod_wood.png"},
	paramtype = "light",
	paramtype2  ="facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("love_mod:wood_heart", {
	description = "Wooden Heart Planks",
	tiles = {"love_mod_wood.png^love_mod_hearts.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

stairs.register_stair_and_slab("love_wood", "love_mod:wood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"love_mod_wood.png"},
		"Love Mod Wooden Stair",
		"Love Mod Wooden Slab",
		default.node_sound_wood_defaults())