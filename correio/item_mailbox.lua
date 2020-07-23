modCorreio.mailbox = { }


modCorreio.openinbox = function(playername)
	--if player ~= nil and player:is_player() then
	if type(playername)=="string" and playername~="" then
		--local playername = player:get_player_name()
		if modCorreio.mailbox[playername]==nil or 
			modCorreio.mailbox[playername].selmail == nil or 
			type(modCorreio.mailbox[playername].selmail)~="number" or 
			modCorreio.mailbox[playername].selmail<0 
		then
			modCorreio.mailbox[playername] = { }
			modCorreio.mailbox[playername].selmail = 0
		end
		
		local formspecmails = modCorreio.get_formspecmails(playername) --<== Retorna os titulos das cartas em formato de formspec
		--minetest.log('action',"formspecmails = "..formspecmails)
		local formspec = "size[8,7.5]"
		.."label[3.25,0;CORREIO]"
		.."textlist[0,0.7;7.7,6;selmail;"..formspecmails..";"..modCorreio.mailbox[playername].selmail..";false]"
		.."button_exit[0.5,7;1.75,0.5;closer;"..minetest.formspec_escape(modCorreio.translate("CLOSE")).."]"
		.."button[2.25,7;1.75,0.5;openmail;"..minetest.formspec_escape(modCorreio.translate("OPEN")).."]"
		.."button[4.0,7;1.75,0.5;delmail;"..minetest.formspec_escape(modCorreio.translate("DELETE")).."]"
		.."button[5.75,7;1.75,0.5;clearmails;"..minetest.formspec_escape(modCorreio.translate("CLEAR")).."]"
		
		minetest.show_formspec(playername,"modCorreio.mailbox",formspec)
	end
end

modCorreio.openmail = function(playername, mailnumber)
	--if player ~= nil and player:is_player() then
		--local playername = player:get_player_name()

	if type(playername)=="string" and playername~="" then
		local mail = modCorreio.get_mail(playername, mailnumber)
		if mail~=nil then
			--local formspecmails = modCorreio.get_formspecmails(playername)
			--minetest.log('action',"formspecmails = "..formspecmails)
			minetest.log('action',"[CORREIO] mail = "..dump(mail))
			local formspec = "size[8,7.5]"
			--.."label[2.75,0;MENSAGEM DE: "..mail.namefrom.."]"
			.."label[0.2,0;"..minetest.formspec_escape(modCorreio.translate("From")..": "..mail.namefrom).."]"
			.."label[0.2,0.45;"..minetest.formspec_escape(modCorreio.translate("When")..": "..os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time)).."]"
			.."button_exit[0.5,7;2,0.5;closer;"..minetest.formspec_escape(modCorreio.translate("CLOSE")).."]"
			.."button[2.5,7;2,0.5;openinbox;"..minetest.formspec_escape(modCorreio.translate("BACK")).."]"
			.."button[4.5,7;2,0.5;delmail;"..minetest.formspec_escape(modCorreio.translate("DELETE")).."]"
			.."textarea[0.5,1.5;7.7,5.5;message;"..
			minetest.formspec_escape(modCorreio.translate("Message")..":")..";"..minetest.formspec_escape(mail.message).."]"
			--.."textlist[0,0.7;15.5,6;selmail;"..formspecmails..";1;false]"
		
			modCorreio.set_read(playername, mailnumber, true)
		
			minetest.show_formspec(playername,"modCorreio.mailbox",formspec)
		end
	end
end

minetest.register_on_player_receive_fields(function(sender, formname, fields)
	if formname == "modCorreio.mailbox"  then
		local playername = sender:get_player_name()
		--minetest.log('action',"[CORREIO] fields = "..dump(fields))
		if fields.openinbox then
			minetest.log('action',"modCorreio.openinbox("..playername..")")
			modCorreio.openinbox(playername)
		elseif fields.selmail then
			local selnum = (fields.selmail):gsub("CHG:", "")
			minetest.log('action',"modCorreio.mailbox[playername].selmail="..dump(modCorreio.mailbox[playername].selmail))
			modCorreio.mailbox[playername].selmail = tonumber(selnum)
		elseif fields.openmail~=nil then
			if modCorreio.mailbox[playername].selmail~=nil and type(modCorreio.mailbox[playername].selmail)=="number" and modCorreio.mailbox[playername].selmail >=1 then
				minetest.log('action',"modCorreio.openmail["..playername.."].selmail="..dump(modCorreio.mailbox[playername].selmail))
				modCorreio.openmail(playername, modCorreio.mailbox[playername].selmail)
			else
				minetest.chat_send_player(playername, modCorreio.translate("Select the letter you want to open!"))
			end
		elseif fields.delmail~=nil then
			if modCorreio.mailbox[playername].selmail~=nil and type(modCorreio.mailbox[playername].selmail)=="number" and modCorreio.mailbox[playername].selmail >=1 then
				minetest.log('action',"modCorreio.del_mail("..playername..", "..modCorreio.mailbox[playername].selmail..")")
				modCorreio.del_mail(playername, modCorreio.mailbox[playername].selmail)
				modCorreio.openinbox(playername)
			else
				minetest.chat_send_player(playername, modCorreio.translate("Select the letter you want to delete!"))
			end
		elseif fields.clearmails~=nil then
			minetest.log('action',"modCorreio.chat_delreadeds("..playername..")")
			modCorreio.chat_delreadeds(playername)
			modCorreio.openinbox(playername)
		end
	end
end)

local mailbox_format = {
	type = "fixed",
	fixed = { 
		{-.25,-.25,.5,			.25,.356,.45}
	}
}
local mailbox_tiles = {
	"tex_mailbox_topdown.png", --cima
	"tex_mailbox_topdown.png", --baixo
	"tex_mailbox_sides.png", --direita
	"tex_mailbox_sides.png".."^[transformFX", --esquerda
	"tex_mailbox_back.png", --traz
	"tex_mailbox_from.png^"..modCorreio.translate("tex_mailbox_from_en.png"), --frente
	--
}

minetest.register_node("correio:mailbox", {
	description = modCorreio.translate("Mailbox (Displays Letters Received)"),
	inventory_image = "obj_mailbox.png",
	--inventory_image = minetest.inventorycube("tex_light.png"),
	drawtype = "nodebox",
	paramtype = "light",
	--paramtype2 = "fixed",
	paramtype2 = "facedir",
	walkable = false,
	node_box =mailbox_format,
	selection_box = mailbox_format,
	tiles = mailbox_tiles,
	--sunlight_propagates = true,
	--light_source = LIGHT_MAX,
	is_ground_content = true, --Nao tenho certeza: Se prega no chao?
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}, --{cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(), --default.node_sound_glass_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.env:get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("infotext", modCorreio.translate("'%s' Mailbox"):format(owner))
		meta:set_string("owner",owner)
	end,
	can_dig = function(pos, player)
		local meta = minetest.env:get_meta(pos)
		if meta~=nil then
			local ownername = meta:get_string("owner")
			local playername = player:get_player_name()
			if ownername~=nil and ownername~="" and ownername~=playername then
				minetest.chat_send_player(playername, modCorreio.translate("You can not destroy the '%s' mailbox!"):format(ownername))
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
				local clickername = clicker:get_player_name()
				if ownername==clickername then
					modCorreio.openinbox(ownername)
				else
					minetest.chat_send_player(clickername, modCorreio.translate("This mailbox belongs to '%s'!"):format(ownername))
				end
			end
		end
	end,
})

minetest.register_craft({
	output = 'correio:mailbox',
	recipe = {
		{"group:wood"	,"group:wood"			,"group:wood"},
		{"group:wood"	,"correio:papermail"	,"group:wood"},
		{"group:wood"	,"group:wood"			,"group:wood"},
	}
})

minetest.register_alias(modCorreio.translate("mailbox")		,"correio:mailbox")
