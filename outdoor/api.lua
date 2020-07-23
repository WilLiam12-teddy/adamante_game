outdoor = { }
outdoor.simbols = { }
outdoor.selected = 1

outdoor.canUse = function(pos, player)
	local meta = minetest.get_meta(pos)
	local playerpos = player:getpos()
	local playername = player:get_player_name()
	local ownername = meta:get_string("owner")
	--print("[outdoor.canUse] playername = "..playername.." ownername = "..ownername)
	if playername == ownername or ownername==""
		or minetest.get_player_privs(playername).server
		or (minetest.get_modpath("tradelands") and modTradeLands.canInteract(pos, playername))
	then
		return true
	end
	return false
end

outdoor.getFormSpecSimbols = function() 
	local formspeclist = ""
	local simbols = outdoor.simbols
	for n, simbol in pairs(simbols) do 
		formspeclist = formspeclist .. minetest.formspec_escape(simbol.description)
		if n < #simbols then
			formspeclist = formspeclist .. ","
		end
	end
	return formspeclist
end

outdoor.getFormSpec = function(numSelected)
	local formspec = "size[4.3,3.7]"
		.."bgcolor[#00440088;false]"
		--..default.gui_bg
		--..default.gui_bg_img
		..default.gui_slots
		.."textlist[0,0;4.0,3.0;selSimbol;"..outdoor.getFormSpecSimbols()..";"..numSelected..";false]"
		.."button_exit[0,3.4;4.2,0.4;btnSelect;SELECIONAR]"
	--print(formspec)
	return formspec
end

outdoor.getGroup = function(id)
	if id == "minetest" then
		return {snappy=3,flammable=2,dig_immediate=3}
	else
		return {snappy=3,flammable=2,dig_immediate=3, not_in_creative_inventory=1}
	end
end

outdoor.register_simbol = function(id, description, tile, hudLabel)
	local qtd = #outdoor.simbols
	outdoor.simbols[qtd+1] = { }
	outdoor.simbols[qtd+1].description = description
	outdoor.simbols[qtd+1].id = id
	outdoor.simbols[qtd+1].hudLabel = hudLabel
	
	minetest.register_node("outdoor:"..id, {
		description = "Letreiro (Outdoor)",
		drawtype = "signlike",
		tiles = {tile},
		inventory_image = tile,
		selection_box = {type="wallmounted",},
		paramtype = 'light',
		light_source = LIGHT_MAX,
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		groups = outdoor.getGroup(id),
		sounds = default.node_sound_wood_defaults(), 
		--drop = 'outdoor:frame',
		drop = "outdoor:minetest",

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", outdoor.getFormSpec(qtd+1))
			if type(hudLabel)=="string" and hudLabel~="" then
				meta:set_string("infotext", hudLabel)
			end
		end,
		--[[ --]]
		after_place_node = function(pos, placer, itemstack)
			local playername = placer:get_player_name()
			local meta = minetest.env:get_meta(pos)
			meta:set_string("formspec", outdoor.getFormSpec(qtd+1))
			meta:set_string("owner", playername)
			if type(hudLabel)=="string" and hudLabel~="" then
				meta:set_string("infotext", hudLabel)
			end
		end,
		--[[
		on_rightclick = function(pos, node, clicker)
			local playername = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			local ownername = meta:get_string("owner")
			local formspec = meta:get_string("formspec")
			print("[outdoor.on_rightclick] playername = "..playername.." ownername = "..ownername)
			if outdoor.canUse(pos, clicker) then
				minetest.show_formspec(
					playername,
					"outdoor_"..playername,
					formspec
				)
			else
				minetest.chat_send_player(playername,"Voce nao pode mudar o letreiro de '"..ownername.."'!")
			end
		end,
		--]]
		--[[
		on_place = function(itemstack, placer, pointed_thing)
			
			local playername = placer:get_player_name()

			if not pointed_thing.type == "node" then
				return itemstack
			end

			local posAbove = pointed_thing.above --acima
			local posUnder = pointed_thing.under --abaixo
			if not placer or not placer:is_player() or
				not minetest.registered_nodes[minetest.get_node(posAbove).name].buildable_to
			then --Verifica se pode construir sobre os objetos construiveis
				return itemstack
			end
		
			local nodeUnder = minetest.get_node(posUnder)
			if minetest.registered_nodes[nodeUnder.name].on_rightclick then --Verifica se o itema na mao do jogador tem funcao rightclick
				return minetest.registered_nodes[nodeUnder.name].on_rightclick(posUnder, nodeUnder, placer, itemstack)
			end
			
			local meta = minetest.get_meta(nodeUnder)
			meta:set_string("formspec", outdoor.getFormSpec(qtd+1))
			if type(hudLabel)=="string" and hudLabel~="" then
				meta:set_string("infotext", hudLabel)
			end
			meta:set_string("owner", playername)
			
			itemstack:take_item() -- itemstack:take_item() = Ok
			return itemstack
		end,
		--]]
		on_receive_fields = function(pos, formname, fields, sender)
			--print("[outdoor.on_receive_fields] [formname = "..dump(formname).."] [fields = "..dump(fields).."]")
			if fields.btnSelect ~=nil then
				--print("[outdoor.on_receive_fields] [outdoor.canUse(pos, sender) = ".. dump(outdoor.canUse(pos, sender)).."]")
				if outdoor.canUse(pos, sender) then
					if type(outdoor.selected)=="number" and outdoor.selected>=1 then
						
						local lado = minetest.get_node(pos).param2
						local id = outdoor.simbols[outdoor.selected].id
						local description = outdoor.simbols[outdoor.selected].description
						local hudLabel = outdoor.simbols[outdoor.selected].hudLabel

						--minetest.chat_send_player(player:get_player_name(),"Voce pressionou o botao o simbolo 'SELECIONAR'!")
						minetest.log('action',sender:get_player_name().." selecionou o outdoor '"..description.."' em "..minetest.pos_to_string(pos))


						minetest.env:add_node(pos, {name="outdoor:"..id})

						local meta = minetest.get_meta(pos)
						meta:set_string("owner", sender:get_player_name())
						if type(hudLabel)=="string" and hudLabel~="" then 
							meta:set_string("infotext", hudLabel)
						end

						local node = minetest.get_node(pos)
						node.param2 = lado
						minetest.swap_node(pos, node)
					end
				else
					local meta = minetest.get_meta(pos)
					minetest.chat_send_player(sender:get_player_name(),"Voce nao pode mudar o letreiro de '"..meta:get_string("owner").."'!")
				end
			elseif fields.selSimbol  then -- quests
				local selnum = (fields.selSimbol):gsub("CHG:", "")
				--minetest.chat_send_player(sender:get_player_name(),"Voce selecionou o simbolo '"..selnum.."'!")
				outdoor.selected = tonumber(selnum)
				return true
			end
		end,
		can_dig = function(pos, digger)
			local canDig = outdoor.canUse(pos, digger)
			if canDig == false then
				local meta = minetest.get_meta(pos)
				minetest.chat_send_player(digger:get_player_name(),"Voce nao pode retirar o letreiro de '"..meta:get_string("owner").."'!")
			end
			--print("[outdoor:on_dig] canDig = "..dump(canDig))
			return canDig
		end,
		--[[ ]]--
	})
	
	--minetest.register_alias("outdoor:minetest" ,"outdoor:"..id) 
end

outdoor.register_simbol("minetest", "Minetest", "simbol_minetest.png") --ATENCAO: Nao pode retirar esta linha

minetest.register_craft({
	output = 'outdoor:minetest',
	recipe = {
		{"default:gold_ingot"	,"default:gold_ingot"	,"default:gold_ingot"},
		{"default:gold_ingot"	,"default:paper"			,"default:gold_ingot"},
		{"default:gold_ingot"	,"default:gold_ingot"	,"default:gold_ingot"},
	}
})

minetest.register_alias("outdoor"		,"outdoor:minetest")
minetest.register_alias("letreiro"		,"outdoor:minetest")

