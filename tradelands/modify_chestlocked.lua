--modTradeLands.ChestLocked = {}
modTradeLands.ChestLocked.idItem = "default:chest_locked"

if modTradeLands.ChestLocked.replaceProtection then
   minetest.register_privilege("checkchest",  {
      	description="The ability to open other players' locked chests", 
      	give_to_singleplayer=false,
   })

modTradeLands.ChestLocked.canUse = function(meta, player)
	if player:get_player_name() == meta:get_string("owner") 
		--or minetest.get_player_privs(player:get_player_name()).server
		or minetest.get_player_privs(player:get_player_name()).checkchest
		or (
			minetest.get_modpath("tradelands")
			and modTradeLands~=nil
			and modTradeLands.getOwnerName(player:getpos())~=""
			and modTradeLands.canInteract(player:getpos(), player:get_player_name())
		)
		or (
			minetest.get_modpath("landrush")
			and landrush~=nil
			and landrush.get_owner(player:getpos())~=nil
			and landrush.can_interact(player:getpos(), player:get_player_name())
		)
	then
		return true
	end
	return false
end

modTradeLands.ChestLocked.getFormSpec = function(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"list[nodemeta:".. spos .. ";main;0,0.3;8,4;]"..
		"list[current_player;main;0,4.85;8,1;]"..
		"list[current_player;main;0,6.08;8,3;8]"..
		"listring[nodemeta:".. spos .. ";main]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0,4.85)
 return formspec
end

if minetest.registered_items[modTradeLands.ChestLocked.idItem] ~= nil then
	local props = minetest.registered_items[modTradeLands.ChestLocked.idItem]
	props.description = "Bau Trancado"
	props.after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Bau Trancado (Propriedade de '"..meta:get_string("owner").."')")
	end
	props.on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Bau Trancado")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end
	props.can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if minetest.get_modpath("anticheater") and modanticheater then modanticheater.doSaveInventory(player, true) end
		return inv:is_empty("main") and modTradeLands.ChestLocked.canUse(meta, player)
	end
	props.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.get_modpath("anticheater") and modanticheater then modanticheater.doSaveInventory(player, true) end
		local meta = minetest.get_meta(pos)
		if not modTradeLands.ChestLocked.canUse(meta, player) then
			return 0
		end
		return count
	end
	props.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.get_modpath("anticheater") and modanticheater then modanticheater.doSaveInventory(player, true) end
		local meta = minetest.get_meta(pos)
		if not modTradeLands.ChestLocked.canUse(meta, player) then
			return 0
		end
		return stack:get_count()
	end
	props.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.get_modpath("anticheater") and modanticheater then modanticheater.doSaveInventory(player, true) end
		local meta = minetest.get_meta(pos)
		if not modTradeLands.ChestLocked.canUse(meta, player) then
			return 0
		end
		return stack:get_count()
	end
	props.on_rightclick = function(pos, node, clicker)
		if minetest.get_modpath("anticheater") and modanticheater then modanticheater.doSaveInventory(clicker, true) end
		local meta = minetest.get_meta(pos)
		if modTradeLands.ChestLocked.canUse(meta, clicker) then
			minetest.show_formspec(
				clicker:get_player_name(),
				"default:chest_locked",
				modTradeLands.ChestLocked.getFormSpec(pos)
			)
		end
	end
	
	if props.type == "node" then
		minetest.register_node(":"..modTradeLands.ChestLocked.idItem, props)
	end
end

--[[
minetest.register_craft({
	type = "shapeless",
	output = "default:chest_locked",
	recipe = { "default:steel_ingot", "default:chest" },
})

minetest.register_craft({
	type = "shapeless",
	output = "default:chest",
	recipe = { "default:steel_ingot", "default:chest_locked" },
})
--]]

end --if modTradeLands.ChestLocked.replaceProtection then

minetest.register_alias("chest_locked"	,modTradeLands.ChestLocked.idItem)
minetest.register_alias("chestlocked"	,modTradeLands.ChestLocked.idItem)
minetest.register_alias("bau_trancado"	,modTradeLands.ChestLocked.idItem)
minetest.register_alias("bautrancado"	,modTradeLands.ChestLocked.idItem)
minetest.register_alias("baucomchave"	,modTradeLands.ChestLocked.idItem)





