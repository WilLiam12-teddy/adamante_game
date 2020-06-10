modHomeFreezer={}
modHomeFreezer.size={width=4,height=8}

minetest.register_privilege("checkchest",  {
	description="O poder abrir  os baus trancados de outros jogadores", 
	give_to_singleplayer=false,
})

modHomeFreezer.canInteract = function(meta, player)
	if player:get_player_name() == meta:get_string("owner") 
		or minetest.get_player_privs(player:get_player_name()).server
		or minetest.get_player_privs(player:get_player_name()).checkchest
		or (minetest.get_modpath("tradelands") and modTradeLands.canInteract(player:getpos(), player:get_player_name()))
	then
		return true
	end
	return false
end

modHomeFreezer.getFormspec = function(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("main", 8*4)
	local formspec = "size[12.5,8]"
	
		--.."bgcolor[#636D76FF;false]"
		.."bgcolor[#FFFFFFBB;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		..default.gui_slots

		.."list[nodemeta:".. spos .. ";main;"
			..((4 - modHomeFreezer.size.width)/2)..","..((8 - modHomeFreezer.size.height)/2)..";"
			..modHomeFreezer.size.width..","..modHomeFreezer.size.height
		..";]" -- <= ATENCAO: Nao pode esquecer o prefixo 'detached:xxxxxxx'
		.."list[current_player;main;4.5,2;8,4;]"
		
		.."listring[nodemeta:".. spos .. ";main]"
		.."listring[current_player;main]"
	--print ("modHomeFreezer.getFormspec("..spos..").formspec = "..formspec)
	return formspec
end

modHomeFreezer.getBoxColision = function()
	return {
		type = "fixed",
		fixed = { 
			{
				-0.45,-0.50,-0.45,			
				 0.45, 1.45, 0.45
			}
		}
	}
end

--"tex_mailbox_sides.png".."^[transformFX", --esquerda

minetest.register_node("homefreezer:refrigerator", {
	description = "Refrigerador",
	--inventory_image = "safe_front.png",
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = modHomeFreezer.getBoxColision(),
	selection_box = modHomeFreezer.getBoxColision(),
	tiles = {
		"refrigerator_sides.png".."^[transformR90]", --cima
		"refrigerator_sides.png".."^[transformR270]", --baixo
		"refrigerator_sides.png", --direita
		"refrigerator_sides.png".."^[transformR180]", --esquerda
		"refrigerator_sides.png".."^[transformR90]", --traz
		"refrigerator_front3.png", --frente
	},
	is_ground_content = false,
	groups = {cracky=1},
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Refrigerador (Propriedade de "..meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", "")
		meta:set_string("infotext", "Cofre")
		local inv = meta:get_inventory()
		inv:set_size("main", 6*2)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and modHomeFreezer.canInteract(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not modHomeFreezer.canInteract(meta, player) then
			minetest.log("action", 
				player:get_player_name().." tentou mover um objeto no Refrigerador de "..meta:get_string("owner").." em "..minetest.pos_to_string(pos)
			)
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not modHomeFreezer.canInteract(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tentou por um objeto no Refrigerador de "..
					meta:get_string("owner").." em "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not modHomeFreezer.canInteract(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tentou pegar um objeto no Refrigerador de "..
					meta:get_string("owner").." em "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moveu um item no Refrigerador em "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" colocou um item no Refrigerador em "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" removeu um item no Refrigerador em "..minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		local playername = clicker:get_player_name()
		--local playername = clicker:get_player_name()
		local meta = minetest.get_meta(pos)
		local ownername = meta:get_string("owner")
		if modHomeFreezer.canInteract(meta, clicker) then
			minetest.show_formspec(playername, "homefreezer:refrigerator",
				modHomeFreezer.getFormspec(pos)
			)
		else
			minetest.chat_send_player(playername, "[HOMEFREEZER] Este Regrigerador pertence a '"..ownername.."'!")
		end
	end,
})

minetest.register_craft({
	output = 'homefreezer:refrigerator',
	recipe = {
		{"default:steel_ingot"	,"default:snowblock"	,"default:steel_ingot"},
		{"default:steel_ingot"	,""						,"default:steel_ingot"},
		{"default:steel_ingot"	,"default:mese"		,"default:steel_ingot"},
	}
})

minetest.register_craft({
	output = 'homefreezer:refrigerator',
	recipe = {
		{"default:steel_ingot"	,"default:ice"		,"default:steel_ingot"},
		{"default:steel_ingot"	,""					,"default:steel_ingot"},
		{"default:steel_ingot"	,"default:mese"	,"default:steel_ingot"},
	}
})


minetest.register_alias("freezer"		,"homefreezer:refrigerator")
minetest.register_alias("frizer"			,"homefreezer:refrigerator")
minetest.register_alias("refrigerator"	,"homefreezer:refrigerator")
minetest.register_alias("refrigerador"	,"homefreezer:refrigerator")
minetest.register_alias("geladeira"		,"homefreezer:refrigerator")

