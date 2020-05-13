local S = minetest.get_translator("itemframes")

minetest.register_entity("itemframes:item",{
	hp_max = 1,
	visual = "wielditem",
	visual_size = {x=0.3,y=0.3},
	physical = false,
	pointable = false,
	textures = { "empty.png" },
	_texture = "empty.png",

	on_activate = function(self, staticdata)
		if staticdata ~= nil and staticdata ~= "" then
			local data = staticdata:split(';')
			if data and data[1] and data[2] then
				self._nodename = data[1]
				self._texture = data[2]
			end
		end
		if self._texture ~= nil then
			self.object:set_properties({textures={self._texture}})
		end
	end,
	get_staticdata = function(self)
		if self._nodename ~= nil and self._texture ~= nil then
			return self._nodename .. ';' .. self._texture
		end
		return ""
	end,

	_update_texture = function(self)
		if self._texture ~= nil then
			self.object:set_properties({textures={self._texture}})
		end
	end,
})


local facedir = {}
facedir[0] = {x=0,y=0,z=1}
facedir[1] = {x=1,y=0,z=0}
facedir[2] = {x=0,y=0,z=-1}
facedir[3] = {x=-1,y=0,z=0}

local remove_item_entity = function(pos, node)
	local objs = nil
	if node.name == "itemframes:item_frame" then
		objs = minetest.get_objects_inside_radius(pos, .5)
	end
	if objs then
		for _, obj in ipairs(objs) do
			if obj and obj:get_luaentity() and obj:get_luaentity().name == "itemframes:item" then
				obj:remove()
			end
		end
	end
end

local update_item_entity = function(pos, node, param2)
	remove_item_entity(pos, node)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local item = inv:get_stack("main", 1)
	if not item:is_empty() then
		if not param2 then
			param2 = node.param2
		end
		if node.name == "itemframes:item_frame" then
			local posad = facedir[param2]
			pos.x = pos.x + posad.x*6.5/16
			pos.y = pos.y + posad.y*6.5/16
			pos.z = pos.z + posad.z*6.5/16
		end
		local e = minetest.add_entity(pos, "itemframes:item")
		local lua = e:get_luaentity()
		lua._nodename = node.name
		if item:get_name() == "" then
			lua._texture = "blank.png"
		else
			lua._texture = item:get_name()
		end
		lua:_update_texture()
		if node.name == "itemframes:item_frame" then
			local yaw = math.pi*2 - param2 * math.pi/2
			e:set_yaw(yaw)
		end
	end
end

local drop_item = function(pos, node, meta)
	if node.name == "itemframes:item_frame" and not minetest.settings:get_bool("creative_mode") then
		local inv = meta:get_inventory()
		local item = inv:get_stack("main", 1)
		if not item:is_empty() then
			minetest.add_item(pos, item)
		end
	end
	meta:set_string("infotext", "")
	remove_item_entity(pos, node)
end

minetest.register_node("itemframes:item_frame",{
	description = ("Item Frame"),
	drawtype = "mesh",
	is_ground_content = false,
	mesh = "itemframes_itemframe1facedir.obj",
	selection_box = { type = "fixed", fixed = {-6/16, -6/16, 7/16, 6/16, 6/16, 0.5} },
	collision_box = { type = "fixed", fixed = {-6/16, -6/16, 7/16, 6/16, 6/16, 0.5} },
	tiles = {"itemframes_frame.png", "itemframes_side.png", "itemframes_side.png", "itemframes_side.png", "itemframes_side.png", "itemframes_side.png"},
	inventory_image = "itemframes_frame.png",
	wield_image = "itemframes_frame.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = { dig_immediate=3,deco_block=1,dig_by_piston=1,container=7 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		if not itemstack then
			return
		end
		local pname = clicker:get_player_name()
		if minetest.is_protected(pos, pname) then
			minetest.record_protection_violation(pos, pname)
			return
		end
		local meta = minetest.get_meta(pos)
		drop_item(pos, node, meta)
		local inv = meta:get_inventory()
		if itemstack:is_empty() then
			remove_item_entity(pos, node)
			meta:set_string("infotext", "")
			inv:set_stack("main", 1, "")
			return itemstack
		end
		local put_itemstack = ItemStack(itemstack)
		put_itemstack:set_count(1)
		inv:set_stack("main", 1, put_itemstack)
		update_item_entity(pos, node)
		-- Add node infotext when item has been named
		local imeta = itemstack:get_meta()
		local iname = imeta:get_string("name")
		if iname then
			meta:set_string("infotext", iname)
		end

		if not minetest.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return count
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return 0
		else
			return stack:get_count()
		end
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		drop_item(pos, node, meta)
	end,
	on_rotate = function(pos, node, user, mode, param2)
		if mode == screwdriver.ROTATE_FACE then
			-- Rotate face
			local meta = minetest.get_meta(pos)
			local node = minetest.get_node(pos)

			local objs = nil
			if node.name == "itemframes:item_frame" then
				objs = minetest.get_objects_inside_radius(pos, .5)
			end
			if objs then
				for _, obj in ipairs(objs) do
					if obj and obj:get_luaentity() and obj:get_luaentity().name == "itemframes:item" then
						update_item_entity(pos, node, (node.param2+1) % 4)
						break
					end
				end
			end
			return
		elseif mode == screwdriver.ROTATE_AXIS then
			-- Place screwdriver into itemframe
			minetest.registered_nodes["itemframes:item_frame"].on_rightclick(pos, node, user, ItemStack("screwdriver:screwdriver"))
			return false
		end
	end,
})

minetest.register_craft({
	output = 'itemframes:item_frame',
	recipe = {
		{'default:stick', 'default:stick', 'default:stick'},
		{'default:stick', 'mobs:leather', 'default:stick'},
		{'default:stick', 'default:stick', 'default:stick'},
	}
})

minetest.register_lbm({
	label = "Update legacy item frames",
	name = "itemframes:update_legacy_item_frames",
	nodenames = {"itemframes:frame"},
	action = function(pos, node)
		-- Swap legacy node, then respawn entity
		node.name = "itemframes:item_frame"
		local meta = minetest.get_meta(pos)
		local item = meta:get_string("item")
		minetest.swap_node(pos, node)
		if item ~= "" then
			local itemstack = ItemStack(minetest.deserialize(meta:get_string("itemdata")))
			local inv = meta:get_inventory()
			inv:set_size("main", 1)
			if not itemstack:is_empty() then
				inv:set_stack("main", 1, itemstack)
			end
		end
		update_item_entity(pos, node)
	end,
})

-- FIXME: Item entities can get destroyed by /clearobjects
minetest.register_lbm({
	label = "Respawn item frame item entities",
	name = "itemframes:respawn_entities",
	nodenames = {"itemframes:item_frame"},
	run_at_every_load = true,
	action = function(pos, node)
		update_item_entity(pos, node)
	end,
})

minetest.register_alias("itemframes:frame", "itemframes:item_frame")
