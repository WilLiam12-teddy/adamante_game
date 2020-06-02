local propCommandMute = function()
	return { 
		params="", 
		privs={},
		description = "Enables and disables the simple sound of your own individual chat. (Do not disable admin alarm)",
		func = function(playername, param)
			modSoundChat.doMute(playername)
			return true
		end,
	}
end

minetest.register_chatcommand("mute", propCommandMute())
minetest.register_chatcommand("mudo", propCommandMute())

--##################################################

local propCommandMuteCall = function()
	return { 
		params="", 
		privs={},
		description = "Enables and disables the alarm sound of call your name.",
		func = function(playername, param)
			modSoundChat.doMuteCall(playername)
			return true
		end,
	}
end

minetest.register_chatcommand("mutecall", propCommandMuteCall())
minetest.register_chatcommand("nomemudo", propCommandMuteCall())
minetest.register_chatcommand("emudecerchamada", propCommandMuteCall())


--##################################################

minetest.register_chatcommand("alert", {
	params = "<message>",
	description = "Send a colored warning with flashy sound for all players (Need the priv 'server')",
	privs = {server=true},
	func = function(playername, params)
		return modSoundChat.doAlert(playername, params)
	end,
})

--##################################################

local propShutdownAlert = function()
   return {
      params = "<secound>",
      description = "Shutdown the server after a public message and a alert sound.",
      privs = {server = true},
      func = function(sendername, param)
         modSoundChat.doShutdownAlert(sendername, param)
      end,
   }
end 

minetest.register_chatcommand('smartshutdown', propShutdownAlert())
minetest.register_chatcommand('sshutdown', propShutdownAlert())
minetest.register_chatcommand('ssd', propShutdownAlert())

--##################################################

--[[
minetest.register_chatcommand("soundchat", {
	params = "",
	description = "Show all commands of mod soundchat.",
	privs = {},
	func = function(playername, param)
		minetest.chat_send_player(playername, "    ", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#00ff00").." ____                        _  ____ _           _   ", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#00ff00").."/ ___|  ___  _   _ _ __   __| |/ ___| |__   __ _| |_ ", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#00ff00").."\\___ \\ / _ \\| | | | '_ \\ / _` | |   | '_ \\ / _` | __|", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#00ff00").." ___) | (_) | |_| | | | | (_| | |___| | | | (_| | |_ ", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#00ff00").."|____/ \\___/ \\__,_|_| |_|\\__,_|\\____|_| |_|\\__,_|\\__|", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#ffff00").."############################################################################################", false)
		minetest.chat_send_player(playername, "FUNCTION:", false)
		minetest.chat_send_player(playername, "   * It emits a simple sound when a player send any message in the chat, ", false)
		minetest.chat_send_player(playername, "     and an audible alarm when a player write his name in the chat. ", false)
		minetest.chat_send_player(playername, "     The admin per command can send a colored warning with flashy sound for all players.", false)
		minetest.chat_send_player(playername, "SINTAX:", false)
		minetest.chat_send_player(playername, "   * "..core.get_color_escape_sequence("#00ff00").."/mute", false)
		minetest.chat_send_player(playername, "   * "..core.get_color_escape_sequence("#00ff00").."/mudo", false)
		minetest.chat_send_player(playername, "       => Enables and disables the simple sound of your own individual chat.", false)
		minetest.chat_send_player(playername, "       	 (Do not disable admin alarm)", false)
		minetest.chat_send_player(playername, "   * "..core.get_color_escape_sequence("#00ff00").."/alert <message>", false)
		minetest.chat_send_player(playername, "       => Send a colored warning with a flashy sound for all players.", false)
		minetest.chat_send_player(playername, "          (Need the priv 'server')", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#ffff00").."############################################################################################", false)
		minetest.chat_send_player(playername, core.get_color_escape_sequence("#00ff00")..playername..", Press F10 and use a mouse scroll to read all this tutorial!", false)
		
		local player = minetest.get_player_by_name(playername)
		if player ~=nil and player:is_player() then
			minetest.sound_play("sfx_chat2", {
				object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
				gain = 1.0, -- 1.0 = Volume total
				--max_hear_distance = 1,
				loop = false,
			})
		end
	end,
})
--]]
