dofile(minetest.get_modpath("cookie_jar").."/api.lua")
dofile(minetest.get_modpath("cookie_jar").."/overrides.lua")

local default_shelf = {
	type = "fixed",
	fixed = {
		{-0.25, -0.5, -0.25, 0.25, 0.00, 0.25},--base
		{-0.18	, 0.00, -0.18, 0.18, 0.0315, 0.18},--lower lip
		{-0.155, 0.0315, -0.155, 0.155, 0.06, 0.155},--upper lip
		{-0.188, 0.06, -0.188, 0.188, 0.15, 0.188},--lid
		{-0.06, 0.15, -0.06, 0.06, 0.19, 0.06},--lid nipple
	}
}


itemshelf.register_shelf("cookie_jar", {
	description = "Cookie Jar",
	textures = {

		"cookie_jar_top.png", --top
		"cookie_jar_bottom.png", --bottom
		"cookie_jar_side.png", --right
		"cookie_jar_side.png", --left
		"cookie_jar_side.png", --back
		"cookie_jar_side.png", --front
	},
	nodebox = default_shelf,
	paramtype2 = "facedir",
	groups = {cracky = 3},
	sounds = default.node_sound_glass_defaults(),
	capacity = 16,
	shown_items = 4,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_vessels_shelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("vessels", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("vessels")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			   " moves stuff in vessels shelf at ".. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_vessels_shelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			   " moves stuff to vessels shelf at ".. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_vessels_shelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			   " takes stuff from vessels shelf at ".. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_vessels_shelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "vessels", drops)
		drops[#drops + 1] = "vessels:shelf"
		minetest.remove_node(pos)
		return drops
	end,
})
