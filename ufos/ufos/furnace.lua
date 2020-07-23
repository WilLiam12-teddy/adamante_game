minetest.register_node("ufos:furnace", {
	description = modUFO.translate("UFO charging device"),
	tiles = {
		"default_obsidian.png^default_mese_crystal.png^gui_hotbar_selected.png", --top
		"default_obsidian.png^default_mese_crystal.png^gui_hotbar_selected.png", --down
		"default_obsidian.png^gui_hotbar_selected.png^obj_ionized_bioresin_32.png", --right
		"default_obsidian.png^gui_hotbar_selected.png^obj_ionized_bioresin_32.png", --left
		"default_obsidian.png^gui_hotbar_selected.png^obj_ionized_bioresin_32.png", --end
		"default_obsidian.png^gui_hotbar_selected.png^[resize:96x96^obj_panel_96.png"-- front
	},
	paramtype2 = "facedir",
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", modUFO.getFormSpecs.furnace())
		meta:set_string("infotext", modUFO.translate("UFO charging device"))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		end
		return true
	end,
})

minetest.register_abm({
	nodenames = {"ufos:furnace"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 32,
			time = 4,
			minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
			maxpos = {x=pos.x+0.5, y=pos.y, z=pos.z+0.5},
			minvel = {x=-0.8,	y=-0.3,	z=-0.8},
			maxvel = {x=0.8,	y=0.3,	z=0.8},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0, y=0, z=0},
			minexptime = 0.5,
			maxexptime = 2,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			vertical = true,
			texture = "reloader_yellow_particle.png",
			--playername = "singleplayer",
		})
	end,
})

--[[
minetest.register_node("ufos:furnace_active", {
	description = modUFO.translate("UFO charging device"),
	tiles = {"default_steel_block.png", "default_steel_block.png", "default_steel_block.png",
		"default_steel_block.png", "default_steel_block.png", 
		"default_steel_block.png^ufos_furnace_front.png^ufos_furnace_front_active.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "ufos:furnace",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", modUFO.getFormSpecs.furnace)
		meta:set_string("infotext", modUFO.translate("UFO charging device"))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		end
		return true
	end,
})
--]]

--[[
function hacky_swap_node(pos,name)
	local node = minetest.env:get_node(pos)
	local meta = minetest.env:get_meta(pos)
	local meta0 = meta:to_table()
	if node.name == name then
		return
	end
	node.name = name
	local meta0 = meta:to_table()
	minetest.env:set_node(pos,node)
	meta = minetest.env:get_meta(pos)
	meta:from_table(meta0)
end
--]]

minetest.register_abm({
	nodenames = {
		"ufos:furnace"
		--,"ufos:furnace_active"
	},
	interval = .25,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack("fuel",1)
		if stack:get_name() == modUFO.fuel_type then
			inv:remove_item("fuel",ItemStack(modUFO.fuel_type))
			meta:set_int("charge",meta:get_int("charge")+1)
			meta:set_string("formspec", 
				modUFO.getFormSpecs.furnace()
				.. "label[1.95,0.6; "..modUFO.translate("Charge: %02d GWh (Gigawatts Hour)"):format(meta:get_int("charge")).. "]"
			)
		end
	end,
})

minetest.register_craft( {
	output = 'ufos:furnace',
	recipe = {
		{ "default:steel_ingot"	, "default:obsidian"		, "default:steel_ingot"	},
		{ "default:furnace"		, "default:mese_block"	, "default:obsidian"		},
		{ "default:steel_ingot"	, "default:obsidian"		, "default:steel_ingot"	},
	},
})

minetest.register_alias("loader","ufos:furnace")
minetest.register_alias("loaderufo","ufos:furnace")
minetest.register_alias(modUFO.translate("loader"),"ufos:furnace")
minetest.register_alias(modUFO.translate("loaderufos"),"ufos:furnace")
minetest.register_alias(modUFO.translate("reloader"),"ufos:furnace")
minetest.register_alias(modUFO.translate("reloaderufos"),"ufos:furnace")
