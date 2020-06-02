modSoundChat = { }
modSoundChat.players = { }

--[[
if core.setting_getbool("soundchat")~= false then
	core.setting_setbool("soundchat", true)
end
--]]
--modSoundChat.terminaldialogs = core.setting_getbool("soundchat")
--modSoundChat.callSendMessage = core.setting_getbool("soundchat.callsendmessage")
--modSoundChat.callPlayerName = core.setting_getbool("soundchat.callplayername")

modSoundChat.isEnabled = function()
   local conf = minetest.setting_get("soundchat")
   if type(conf)=="nil" or conf == "" then
         conf = true
      minetest.setting_setbool("soundchat", conf)
   end
   return conf
end

modSoundChat.isPrintTerminalDialogs = function()
   local conf = minetest.setting_get("soundchat.terminaldialogs")
   if type(conf)=="nil" or conf == "" then
      conf = true
      core.setting_setbool("soundchat.terminaldialogs", conf)
   end
   return conf
end

modSoundChat.isCall = {
   SendMessage = function()
      local conf = minetest.setting_get("soundchat.call.onsendmessage")
      if type(conf)=="nil" or conf == "" then
         conf = true
         core.setting_setbool("soundchat.call.onsendmessage", conf)
      end
      return conf
   end,
   PlayerName = function()
      local conf = minetest.setting_get("soundchat.call.onplayername")
      if type(conf)=="nil" or conf == "" then
         conf = true
         core.setting_setbool("soundchat.call.onplayername", conf)
      end
      return conf
   end,
}

if core.setting_getbool("disable_escape_sequences")~= false then
	core.setting_setbool("disable_escape_sequences", true)
	--core.colorize(color, message)
	--core.get_background_escape_sequence("#00ff00")
	--core.get_color_escape_sequence("#ff0000")
end

modSoundChat.doAlert = function(sendername, msg)
	if type(msg)=="string" and msg~="" then
		local players = minetest.get_connected_players()
		for _, player in pairs(players) do
			if player~=nil and player:is_player() then
				minetest.sound_play("sfx_alertfire", {object=player})
				local playername = player:get_player_name()
			
				local form = "\n"
					..core.get_color_escape_sequence("#ff0000").."#######################################################################################\n"
					..core.get_color_escape_sequence("#ff0000").."###    "..core.get_color_escape_sequence("#00ff00").."AVISO DO ADMINISTRADOR:\n"
					..core.get_color_escape_sequence("#ff0000").."###         "..core.get_color_escape_sequence("#ffffFF").." -> "..msg.."\n"
					..core.get_color_escape_sequence("#ff0000").."#######################################################################################\n"
				minetest.chat_send_player(playername, form)
				--minetest.log('action',form)
			end
		end
		return true, ""
	else
		minetest.chat_send_player(sendername, "["..core.get_color_escape_sequence("#00ff00").."SOUNDCHAT"..core.get_color_escape_sequence("#ffffff")..":"..core.get_color_escape_sequence("#ff0000").."ERRO"..core.get_color_escape_sequence("#ffffff").."] "..core.get_color_escape_sequence("#8888ff").."/alert <message> ", false)
	end
	return false
end

modSoundChat.doTimerShutdown = function(secounds, message)
   if type(secounds)=="number" then
      if secounds>=0 then
         modSoundChat.timeCounter = secounds
      else
         avisodeerror()
      end
   else
      if type(modSoundChat.timeCounter)~="number" or modSoundChat.timeCounter<0 then
         modSoundChat.timeCounter = 0
      else
         modSoundChat.timeCounter = modSoundChat.timeCounter - 1
      end
   end
   if type(message)=="string" and message~="" then
      modSoundChat.textShutdown = message
   end
   if modSoundChat.timeCounter < 1 then 
      if type(modSoundChat.textShutdown)=="string" and modSoundChat.textShutdown~="" then
         minetest.chat_send_all(core.colorize("#ff0000", modSoundChat.textShutdown))
      end
      minetest.request_shutdown()
   elseif modSoundChat.timeCounter % 5 == 0 and type(modSoundChat.textShutdown)=="string" and modSoundChat.textShutdown~="" then
      minetest.chat_send_all((("Reiniciando em: %02d"):format(modSoundChat.timeCounter)).." ("..core.colorize("#ff0000", modSoundChat.textShutdown)..")")
      minetest.after(1.0, modSoundChat.doTimerShutdown)
   else
      minetest.chat_send_all(("Reiniciando em: %02d"):format(modSoundChat.timeCounter))
      minetest.after(1.0, modSoundChat.doTimerShutdown)
   end
end

modSoundChat.doShutdownAlert = function(sendername, params)
   local message = "Servidor sera reiniciado. Voltamos dentro de 5 minutos..."
   modSoundChat.doAlert(sendername, message)
   if params == nil or params == "" then
      modSoundChat.doTimerShutdown(30, message)
   elseif(params:find("%D+")) then
      modSoundChat.doTimerShutdown(30, message)
   else 
      modSoundChat.doTimerShutdown(tonumber(params), message)
   end
end

modSoundChat.doMute = function(playername)
	if type(playername)=="string" and playername~="" then
		if not modSoundChat.players[playername] then 
			modSoundChat.players[playername] = { }
		end
		modSoundChat.players[playername].mute = not (type(modSoundChat.players[playername].mute)=="boolean" and modSoundChat.players[playername].mute==true)
		if not modSoundChat.players[playername].mute then --Verifica se o chat esta ativado!
			minetest.chat_send_player(playername, "["..core.get_color_escape_sequence("#00ff00").."SOUNDCHAT"..core.get_color_escape_sequence("#ffffff").."] O sonorizador de chat foi "..core.get_color_escape_sequence("#00ffff").."ativado"..core.get_color_escape_sequence("#ffffff").."!")
		else
			minetest.chat_send_player(playername, "["..core.get_color_escape_sequence("#00ff00").."SOUNDCHAT"..core.get_color_escape_sequence("#ffffff").."] O sonorizador de chat foi "..core.get_color_escape_sequence("#ff0000").."desativado"..core.get_color_escape_sequence("#ffffff").."!")
		end
		local player = minetest.get_player_by_name(playername)
		if player ~=nil and player:is_player() then
    			minetest.sound_play("sfx_chat2", {
    				object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
    				gain = 1.0, -- 1.0 = Volume total
    				--max_hear_distance = 1,
    				loop = false,
    			})
		end
		return modSoundChat.players[playername].mute
	end
end

modSoundChat.doMuteCall = function(playername)
	if type(playername)=="string" and playername~="" then
		if not modSoundChat.players[playername] then 
			modSoundChat.players[playername] = { }
		end
		modSoundChat.players[playername].muteCall = not (type(modSoundChat.players[playername].muteCall)=="boolean" and modSoundChat.players[playername].muteCall==true)
		if not modSoundChat.players[playername].muteCall then --Verifica se a chamada de nome de jogador esta ativada!
			minetest.chat_send_player(playername, "["..core.get_color_escape_sequence("#00ff00").."SOUNDCHAT"..core.get_color_escape_sequence("#ffffff").."] O sonorizador de chamada de nome de jogador foi "..core.get_color_escape_sequence("#00ffff").."ativado"..core.get_color_escape_sequence("#ffffff").."!")
		else
			minetest.chat_send_player(playername, "["..core.get_color_escape_sequence("#00ff00").."SOUNDCHAT"..core.get_color_escape_sequence("#ffffff").."] O sonorizador de chamada de nome de jogador foi "..core.get_color_escape_sequence("#ff0000").."desativado"..core.get_color_escape_sequence("#ffffff").."!")
		end
		local player = minetest.get_player_by_name(playername)
		if player ~=nil and player:is_player() then
    			minetest.sound_play("sfx_chat2", {
    				object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
    				gain = 1.0, -- 1.0 = Volume total
    				--max_hear_distance = 1,
    				loop = false,
    			})
		end
		return modSoundChat.players[playername].muteCall
	end
end

--minetest.register_on_receiving_chat_message(function(sendername,msg)
--minetest.register_on_sending_chat_message(function(sendername,msg)

minetest.register_on_chat_message(function(sendername, msg)
	if minetest.get_player_privs(sendername).shout then
   if modSoundChat.isPrintTerminalDialogs() then
      print("<"..sendername.."> "..msg)
   end

	for i,player in ipairs(minetest.get_connected_players()) do
		if player and player:is_player() and player:get_player_name() then
			local playername = player:get_player_name()
			
			if minetest.get_player_privs(sendername).server then
				minetest.chat_send_player(
					playername, 
					core.colorize("#FF0000", ""..sendername.." (Admin): ")..msg
				)
			else
				minetest.chat_send_player(
					playername, 
					core.colorize("#00FF00", sendername..": ")..msg
				)
			end
			--]]
			if modSoundChat.isEnabled() and type(msg)=="string" and msg:len()>=3 then
				if playername~=sendername then --Toca para todos ,exceto para quem enviou a mensagem.
					if not modSoundChat.players[playername] then 
						modSoundChat.players[playername] = { }
					end
					if modSoundChat.players[playername].handler ~=nil then 
						minetest.sound_stop(modSoundChat.players[playername].handler)
					end
					modSoundChat.players[playername].mute = (type(modSoundChat.players[playername].mute)=="boolean" and modSoundChat.players[playername].mute==true)
					modSoundChat.players[playername].muteCall = (type(modSoundChat.players[playername].muteCall)=="boolean" and modSoundChat.players[playername].muteCall==true)
				
					if msg:lower():find(playername:lower())
						or (
							msg:len()>=4 and playername:lower():find(msg:lower())
						)
					then --#################### CHAMAR ATENÇÃO #########################################################
    if not modSoundChat.players[playername].muteCall then
       if modSoundChat.isCall.PlayerName() then
   						    modSoundChat.players[playername].handler = minetest.sound_play("sfx_chat_playername", {
   							    object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
   		    					gain = 1.0, -- 1.0 = Volume total
   			    				max_hear_distance = 0,
   		    					loop = false,
   		    				})
       end
   						minetest.chat_send_player(playername, 
   							--core.get_color_escape_sequence("#ffff00")..sendername..core.get_color_escape_sequence("#00ffff").." citou seu nome!"
   							core.colorize("#FF00FF", "[SOUNDCHAT] ")
   							..("O '%s' citou seu nome!"):format(core.colorize("#FFFF00", sendername))
   						)
    end
					elseif not modSoundChat.players[playername].mute then --#################### CONVERSA COMUM #########################################################
    if modSoundChat.isCall.SendMessage() then
    						modSoundChat.players[playername].handler = minetest.sound_play("sfx_chat_speak", {
    							object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
    							gain = 1.0, -- 1.0 = Volume total
    							max_hear_distance = 0,
    							loop = false,
    						})
    end
					end
				end
			end --Fim de if modSoundChat.isEnabled() and msg and msg:len()>=2 then
		end --if player and player:is_player() and player:get_player_name() then
	end --Fim de for
	return true
   end --if minetest.get_player_privs(sendername).shout then
end)

minetest.register_on_joinplayer(function(player)
	minetest.sound_play("sfx_login", {
		--object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
		gain = 1.0, -- 1.0 = Volume total
		--max_hear_distance = 64000,
		loop = false,
	})
end)

minetest.register_on_leaveplayer(function(player)
	minetest.sound_play("sfx_logout", {
		--object = player, --Se retirar esta linha tocará para todos. (Provavelmente ¬¬)
		gain = 1.0, -- 1.0 = Volume total
		--max_hear_distance = 64000,
		loop = false,
	})
end)
