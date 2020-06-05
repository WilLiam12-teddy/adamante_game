if modAdminTag.player_invisible==nil then
	modAdminTag.player_invisible = { }
end

modAdminTag.translate = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end


minetest.register_privilege("nametaginvisible",  {
	description=modAdminTag.translate("Lets invisible or visible the nametag of player."), 
	give_to_singleplayer=false,
})

modAdminTag.setNametagColor = function(player)
	if player and player:is_player() then --Verifica se o player esta online
		local playername = player:get_player_name()
		if type(modAdminTag.player_invisible[playername])=="boolean" and modAdminTag.player_invisible[playername]==true then
			player:set_nametag_attributes({color={a=0,r=0,g=0,b=0}})
		else
			if minetest.get_player_privs(playername).server then
				player:set_nametag_attributes({color=modAdminTag.nametagcolor_server})
			else
				player:set_nametag_attributes({color=modAdminTag.nametagcolor_normal})
			end
		end
	end
end

modAdminTag.doChangeInvisible = function (playername)
	local player = minetest.get_player_by_name(playername)
	if player and player:is_player() then --Verifica se o player esta online
		modAdminTag.player_invisible[playername] = not modAdminTag.player_invisible[playername]
		modAdminTag.setNametagColor(player)
		if modAdminTag.player_invisible[playername] then
			minetest.chat_send_player(playername, 
				core.get_color_escape_sequence("#FFFFFF").."["..
				core.get_color_escape_sequence("#00FF00")..
				"ADMINTAG"..
				core.get_color_escape_sequence("#FFFFFF")..
				"] "..
				modAdminTag.translate("The nametag of '%s' has makes invisible."):format(playername)
			)
			if minetest.get_modpath("lib_savelogs") and libSaveLogs~=nil then
				libSaveLogs.addLog(
					"<admintag> "..
					modAdminTag.translate("The player '%s' has makes invisible your nametag. %s"):
					format(
						playername, 
						minetest.pos_to_string(libSaveLogs.getPosResumed(minetest.get_player_by_name(playername):getpos()))
					)
				)
				libSaveLogs.doSave()
			end
		else
			minetest.chat_send_player(playername, 
				core.get_color_escape_sequence("#FFFFFF").."["..
				core.get_color_escape_sequence("#00FF00")..
				"ADMINTAG"..
				core.get_color_escape_sequence("#FFFFFF")..
				"] "..
				modAdminTag.translate("The nametag of '%s' has makes visible."):format(playername)
			)
			if minetest.get_modpath("lib_savelogs") and libSaveLogs~=nil then
				libSaveLogs.addLog(
					"<admintag> "..
					modAdminTag.translate("The player '%s' has makes visible your nametag. %s"):
					format(
						playername, 
						minetest.pos_to_string(libSaveLogs.getPosResumed(minetest.get_player_by_name(playername):getpos()))
					)
				)
				libSaveLogs.doSave()
			end
		end
		return true
	else
		return false
	end
end

minetest.register_on_joinplayer(function(player)
	modAdminTag.setNametagColor(player)
end)

minetest.register_chatcommand("nametaginvisible", {
	params = "",
	description = modAdminTag.translate("Makes invisible or visible the nametag of player."),
	privs = {nametaginvisible=true},
	func = function(playername, param)
		return modAdminTag.doChangeInvisible(playername)
	end,
})

minetest.register_chatcommand("nti", {
	params = "",
	description = modAdminTag.translate("Makes invisible or visible the nametag of player."),
	privs = {nametaginvisible=true},
	func = function(playername, param)
		return modAdminTag.doChangeInvisible(playername)
	end,
})
