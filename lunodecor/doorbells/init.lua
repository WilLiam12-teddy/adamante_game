local doorbell_format = {
	type = "fixed",
	fixed = { 
		{-.25,-.25,.5,			.25,.25,.45},
		{-.125,-.125,.45,		.125,.125,.40}
	}
}
local doorbell_tiles = {
	"text_doorbell_sides.png", --cima
	"text_doorbell_sides.png".."^[transformR180", --baixo
	"text_doorbell_sides.png".."^[transformR270", --direita
	"text_doorbell_sides.png".."^[transformR90", --esquerda
	"text_doorbell_back.png", --traz
	"text_doorbell_from.png", --frente
	--
}

minetest.register_node("doorbells:doorbell", {
	description = "Campainha (Sem Recall = Ctrl+Instalar)",
	inventory_image = "obj_doorbeel.png",
	--drawtype = "glasslike",
	drawtype = "nodebox",
	paramtype = "light",
	--paramtype2 = "fixed",
	paramtype2 = "facedir",
	walkable = false,
	node_box =doorbell_format,
	selection_box = doorbell_format,
	tiles = doorbell_tiles,
	--inventory_image = minetest.inventorycube("tex_light.png"),
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	is_ground_content = true, --Nao tenho certeza: Se prega no chao?
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}, --{cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(), --default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.env:get_meta(pos)
		if not placer:get_player_control().aux1 then --Se o Player segurar "CTRL" a campainha sera instalado sem dono.
			local owner = placer:get_player_name()
			meta:set_string("infotext", "Campainha Recall de '"..owner.."'")
			meta:set_string("owner",owner)
		else
			meta:set_string("infotext", "Campainha (sem recall)")
		end
	end,
	can_dig = function(pos, player)
		local meta = minetest.env:get_meta(pos)
		if meta~=nil then
			local ownername = meta:get_string("owner")
			local playername = player:get_player_name()
			if ownername~=nil and ownername~="" and ownername~=playername then
				minetest.chat_send_player(playername, "Voce nao pode destruir a campainha de "..ownername..".")
				return false
			else
				return true
			end
		else
			return true
		end
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.env:get_meta(pos)
		if meta~=nil then
			local ownername = meta:get_string("owner")
			if ownername~=nil and ownername~="" then
				local ownerplayer = minetest.env:get_player_by_name(ownername)
				local clickername = clicker:get_player_name()
				if ownerplayer~=nil and ownerplayer:is_player() then --Verificar se o don oesta online
					minetest.chat_send_player(ownername, clickername.." esta chamando sua atencao!!!")
					minetest.sound_play("sfx_doorbell", {object=ownerplayer, gain=0.1, max_hear_distance=1.0,})
					
					minetest.chat_send_player(clickername,"Voce esta chamando a atencao de '"..ownername.."'!")
					minetest.sound_play("sfx_doorbell", {object=clicker, gain=0.1, max_hear_distance=1.0,})
				else
					minetest.chat_send_player(clickername, "Aparentemente "..ownername.." nao esta em casa!")
					minetest.sound_play("sfx_doorbell", {object=clicker, gain=0.1, max_hear_distance=1.0,})
				end
			else --Caso a campainha nao tenha dono
				minetest.sound_play("sfx_doorbell", {object=clicker, gain=0.1, max_hear_distance=10.0,})
			end
		end
	end,
})

minetest.register_craft({
	output = 'doorbells:doorbell',
	recipe = {
		{"group:wood"	,"group:wood"	,"group:wood"},
		{"group:wood"	,"lamps:lamp"	,"group:wood"},
		{"group:wood"	,"group:wood"	,"group:wood"},
	}
})

minetest.register_alias("doorbell"	,"doorbells:doorbell")
minetest.register_alias("campainha"	,"doorbells:doorbell")

