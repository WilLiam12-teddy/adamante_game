local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

homefans = {}

homefans.fdir_to_right = {{1,0},{0,-1},{-1,0},{0,1},}
homefans.fdir_to_fwd = {{0,1},{1,0},{0,-1},{-1,0},}
homefans.nodebox = {
	desk_fan = { type = "fixed", fixed = {-0.2,-0.5,-0.2,	0.2,0.3,0.2} },
	regular = { type="regular" },
	null = { type = "fixed", fixed = { 0, 0, 0, 0, 0, 0 } },
}


function homefans.stack_vertically(itemstack, placer, pointed_thing, node1, node2)
	local pos, def = select_node(pointed_thing)
	if not def then return end -- rare corner case, but happened in #205

	if def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, minetest.get_node(pos), placer, itemstack)
	end

	local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }

	return stack(itemstack, placer, nil, pos, def, top_pos, node1, node2)
end

function homefans.stack_sideways(itemstack, placer, pointed_thing, node1, node2, dir)
	local pos, def = select_node(pointed_thing)
	if not def then return end -- rare corner case, but happened in #205

	if def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, minetest.get_node(pos), placer, itemstack)
	end

	local fdir = minetest.dir_to_facedir(placer:get_look_dir())
	local fdir_transform = dir and homefans.fdir_to_right or homefans.fdir_to_fwd

	local pos2 = { x = pos.x + fdir_transform[fdir+1][1], y=pos.y, z = pos.z + fdir_transform[fdir+1][2] }

	return stack(itemstack, placer, fdir, pos, def, pos2, node1, node2)
end

homefans.register = function(name, def)
	def.drawtype = def.drawtype
			or (def.mesh and "mesh")
			or (def.node_box and "nodebox")

	def.paramtype = def.paramtype or "light"

	-- avoid facedir for some drawtypes as they might be used internally for something else
	-- even if undocumented
	if not (def.drawtype == "glasslike_framed"
		or def.drawtype == "raillike"
		or def.drawtype == "plantlike"
		or def.drawtype == "firelike") then

		def.paramtype2 = def.paramtype2 or "facedir"
	end

	local infotext = def.infotext
	--def.infotext = nil -- currently used to set locked refrigerator infotexts

	-- handle inventory setting
	-- inventory = {
	--	size = 16
	--	formspec = …
	-- }
	local inventory = def.inventory
	def.inventory = nil

	if inventory then
		def.on_construct = def.on_construct or function(pos)
			local meta = minetest.get_meta(pos)
			if infotext then
				meta:set_string("infotext", infotext)
			end
			local size = inventory.size or default_inventory_size
			meta:get_inventory():set_size("main", size)
			meta:set_string("formspec", inventory.formspec or get_formspec_by_size(size))
		end

		def.can_dig = def.can_dig or default_can_dig
		def.on_metadata_inventory_move = def.on_metadata_inventory_move or function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", S("%s moves stuff in %s at %s"):format(
				player:get_player_name(), name, minetest.pos_to_string(pos)
			))
		end
		def.on_metadata_inventory_put = def.on_metadata_inventory_put or function(pos, listname, index, stack, player)
			minetest.log("action", S("%s moves stuff to %s at %s"):format(
				player:get_player_name(), name, minetest.pos_to_string(pos)
			))
		end
		def.on_metadata_inventory_take = def.on_metadata_inventory_take or function(pos, listname, index, stack, player)
			minetest.log("action", S("%s takes stuff from %s at %s"):format(
				player:get_player_name(), name, minetest.pos_to_string(pos)
			))
		end
	elseif infotext and not def.on_construct then
		def.on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", infotext)
		end
	end

	local expand  = def.expand
	def.expand = nil
	local after_unexpand = def.after_unexpand
	def.after_unexpand = nil

	if expand then
		def.on_place = def.on_place or function(itemstack, placer, pointed_thing)
			if expand.top then
				return homefans.stack_vertically(itemstack, placer, pointed_thing, itemstack:get_name(), expand.top)
			elseif expand.right then
				return homefans.stack_sideways(itemstack, placer, pointed_thing, itemstack:get_name(), expand.right, true)
			elseif expand.forward then
				return homefans.stack_sideways(itemstack, placer, pointed_thing, itemstack:get_name(), expand.forward, false)
			end
		end
		def.after_dig_node = def.after_dig_node or function(pos, oldnode, oldmetadata, digger)
			if expand.top and expand.forward ~= "air" then
				local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }
				if minetest.get_node(top_pos).name == expand.top then
					minetest.remove_node(top_pos)
				end
			end

			local fdir = oldnode.param2
			if not fdir or fdir > 3 then return end

			if expand.right and expand.forward ~= "air" then
				local right_pos = { x=pos.x+homefans.fdir_to_right[fdir+1][1], y=pos.y, z=pos.z+homefans.fdir_to_right[fdir+1][2] }
				if minetest.get_node(right_pos).name == expand.right then
					minetest.remove_node(right_pos)
				end
			end
			if expand.forward and expand.forward ~= "air" then
				local forward_pos = { x=pos.x+homefans.fdir_to_fwd[fdir+1][1], y=pos.y, z=pos.z+homefans.fdir_to_fwd[fdir+1][2] }
				if minetest.get_node(forward_pos).name == expand.forward then
					minetest.remove_node(forward_pos)
				end
			end

			if after_unexpand then
				after_unexpand(pos)
			end
		end
	end

	if type(def.recipe)=="table" then
		minetest.register_craft( {
			output = "homefans:" .. name,
			recipe = def.recipe,
		})
	end

	if type(def.alias)=="table" and #def.alias>=1 then
		for i=1, #def.alias do
			if type(def.alias[i])=="string" and def.alias[i]~="" then
				minetest.register_alias(def.alias[i] ,"homefans:" .. name)
			end
		end
	end
	
	
	

	-- register the actual minetest node
	minetest.register_node("homefans:" .. name, def)
end
