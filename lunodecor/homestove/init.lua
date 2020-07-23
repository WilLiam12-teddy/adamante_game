homestove = { }

homestove.getFormActive = function(fuel_percent, item_percent)
	local formspec = 
		"size[8,8.5]"..
		"bgcolor[#FFFFFFBB;false]"..
		--default.gui_bg..
		--default.gui_bg_img..
		default.gui_slots..
		"list[current_name;src;2.75,0.5;1,1;]"..
		"list[current_name;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
		(100-fuel_percent)..":default_furnace_fire_fg.png]"..
		"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[current_name;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		default.get_hotbar_bg(0, 4.25)
	return formspec
end

homestove.getFormInactive = function()
	return "size[8,8.5]"..
		"bgcolor[#FFFFFFBB;false]"..
	--default.gui_bg..
	--default.gui_bg_img..
	default.gui_slots..
	"list[current_name;src;2.75,0.5;1,1;]"..
	"list[current_name;fuel;2.75,2.5;1,1;]"..
	"image[2.75,1.5;1,1;default_furnace_fire_bg.png]"..
	"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
	"list[current_name;dst;4.75,0.96;2,2;]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	default.get_hotbar_bg(0, 4.25)
end

homestove.can_dig = function(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")
end

homestove.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", "Fogao esta Vazio")
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

homestove.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return homestove.allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

homestove.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

minetest.register_node("homestove:cooker", {
	description = "Fogao",
	tiles = {
		"text_stove_top.png", 
		"text_stove_bottom.png",
		"text_stove_side.png", 
		"text_stove_side.png",
		"text_stove_side.png", 
		"text_stove_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	
	can_dig = homestove.can_dig,
	
	allow_metadata_inventory_put = homestove.allow_metadata_inventory_put,
	allow_metadata_inventory_move = homestove.allow_metadata_inventory_move,
	allow_metadata_inventory_take = homestove.allow_metadata_inventory_take,
})

minetest.register_node("homestove:cooker_active", {
	description = "Fogao",
	tiles = {
		"text_stove_top.png", 
		"text_stove_bottom.png",
		"text_stove_side.png", 
		"text_stove_side.png",
		"text_stove_side.png",
		{
			image = "text_stove_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
	paramtype2 = "facedir",
	paramtype = "light", --Nao sei pq, mas o bloco nao aceita a luz se nao tiver esta propriedade
	light_source = default.LIGHT_MAX - 3, --de 0 a 14
	drop = "homestove:cooker",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	
	can_dig = homestove.can_dig,
	
	allow_metadata_inventory_put = homestove.allow_metadata_inventory_put,
	allow_metadata_inventory_move = homestove.allow_metadata_inventory_move,
	allow_metadata_inventory_take = homestove.allow_metadata_inventory_take,
})

homestove.swap_node = function(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

minetest.register_abm({
	nodenames = {"homestove:cooker", "homestove:cooker_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		--
		-- Inizialize metadata
		--
		local meta = minetest.get_meta(pos)
		local fuel_time = meta:get_float("fuel_time") or 0
		local src_time = meta:get_float("src_time") or 0
		local fuel_totaltime = meta:get_float("fuel_totaltime") or 0
		
		--
		-- Inizialize inventory
		--
		local inv = meta:get_inventory()
		for listname, size in pairs({
				src = 1,
				fuel = 1,
				dst = 4,
		}) do
			if inv:get_size(listname) ~= size then
				inv:set_size(listname, size)
			end
		end
		local srclist = inv:get_list("src")
		local fuellist = inv:get_list("fuel")
		local dstlist = inv:get_list("dst")
		
		--
		-- Cooking
		--
		
		-- Check if we have cookable content
		local cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		local cookable = true
		
		if cooked.time == 0 then
			cookable = false
		end
		
		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The furnace is currently active and has enough fuel
			fuel_time = fuel_time + 1
			
			-- If there is a cookable item then check if it is ready yet
			if cookable then
				src_time = src_time + 1
				if src_time >= cooked.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", cooked.item) then
						inv:add_item("dst", cooked.item)
						inv:set_stack("src", 1, aftercooked.items[1])
						src_time = 0
					end
				end
			end
		else
			-- Furnace ran out of fuel
			if cookable then
				-- We need to get new fuel
				local fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
				
				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					fuel_time = 0
					src_time = 0
				else
					-- Take fuel from fuel list
					inv:set_stack("fuel", 1, afterfuel.items[1])
					
					fuel_totaltime = fuel.time
					fuel_time = 0
					
				end
			else
				-- We don't need to get new fuel since there is no cookable item
				fuel_totaltime = 0
				fuel_time = 0
				src_time = 0
			end
		end
		
		--
		-- Update formspec, infotext and node
		--
		local formspec = homestove.getFormInactive()
		local item_state = ""
		local item_percent = 0
		if cookable then
			item_percent =  math.floor(src_time / cooked.time * 100)
			item_state = item_percent .. "% Assado"
		else
			if srclist[1]:is_empty() then
				item_state = "Nenhum"
			else
				item_state = "Nao Cozinhavel"
			end
		end
		
		local fuel_state = "Vazio"
		local active = "Apagado "
		if fuel_time <= fuel_totaltime and fuel_totaltime ~= 0 then
			active = "Ativo "
			local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
			fuel_state = fuel_percent .. "%"
			formspec = homestove.getFormActive(fuel_percent, item_percent)
			homestove.swap_node(pos, "homestove:cooker_active")
		else
			if not fuellist[1]:is_empty() then
				fuel_state = "0%"
			end
			homestove.swap_node(pos, "homestove:cooker")
		end
		
		local infotext =  "Fogao " .. active .. "(Item:" .. item_state .. "; Combustivel:" .. fuel_state .. ")"
		
		meta:set_float("fuel_totaltime", fuel_totaltime)
		meta:set_float("fuel_time", fuel_time)
		meta:set_float("src_time", src_time)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", infotext)
	end,
})

minetest.register_craft({
	output = 'homestove:cooker',
	recipe = {
		{"default:mese_crystal"	,"default:mese_crystal"		,"default:mese_crystal"},
		{"default:steel_ingot"	,"default:obsidian_glass"	,"default:steel_ingot"},
		{"default:steel_ingot"	,"default:obsidian"			,"default:steel_ingot"},
	}
})

minetest.register_alias("homestove"				,"homestove:cooker")
minetest.register_alias("stove"					,"homestove:cooker")
minetest.register_alias("cooker"					,"homestove:cooker")
minetest.register_alias("fogao"					,"homestove:cooker")
minetest.register_alias("forno"					,"homestove:cooker")
minetest.register_alias("fogaodomestico"		,"homestove:cooker")
minetest.register_alias("fornodomestico"		,"homestove:cooker")

minetest.log('action',"["..minetest.get_current_modname():upper().."] Carregado!")
