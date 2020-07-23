minetest.register_privilege("postman",  {
	description=modCorreio.translate("Player can send messages directly by command."), 
	give_to_singleplayer=false,
})

minetest.register_privilege("walkingreader",  {
	description=modCorreio.translate("Player can readd messages directly by command."), 
	give_to_singleplayer=false,
})

modCorreio.setDataBase = function(nameto, tblCorreio)
	modsavevars.setCharValue(nameto, "tblCorreio", tblCorreio)
end

modCorreio.getDataBase = function(nameto)
	local tblCorreio=modsavevars.getCharValue(nameto, "tblCorreio")
	if type(tblCorreio)~="table" then tblCorreio={}	end
	if type(tblCorreio.messages)~="table" then tblCorreio.messages={}	end
	return tblCorreio
end

modCorreio.set_mail = function(namefrom, nameto, message)
	if namefrom~=nil and type(namefrom)=="string" and namefrom~="" then
		if nameto~=nil and type(nameto)=="string" and nameto~="" then
			if message~=nil and type(message)=="string" and message~="" then
				local tmp = { }
				tmp.namefrom = namefrom
				tmp.message = modCorreio.regulechars(message)
				tmp.time = os.time()
				tmp.readed = false
				
				local tblCorreio=modCorreio.getDataBase(nameto)
				table.insert(tblCorreio.messages,tmp)
				modCorreio.setDataBase(nameto, tblCorreio)
				
				return tmp
			else
				minetest.log("error","[modCorreio.set_mail()] message = "..dump(message))
			end
		else
			minetest.log("error","[modCorreio.set_mail()] nameto = "..dump(nameto))
		end
	else
		minetest.log("error","[modCorreio.set_mail()] namefrom = "..dump(namefrom))
	end
end

modCorreio.chat_writemail = function(name, param) --Usado apenas por comando de chat
	if name~=nil and type(name)=="string" and name~="" then
		if param~=nil and type(param)=="string" and param~="" then
			local to, msg = string.match(param, "([%a%d_]+) (.+)")
			
			if not to or not msg then
				minetest.chat_send_player(name,"/mail <to_player> <mensagem>")
				return false
			end
			
			print(modCorreio.translate("Sender")..": "..name) --Remetente
			print(modCorreio.translate("Addressee")..": "..to) --Destinatário
			print(modCorreio.translate("Message")..": "..msg) --Mensagem
			
			
			local result = modCorreio.set_mail(name, to, msg)
			if result~=nil then
				minetest.chat_send_player(name,modCorreio.translate("Your message was sent to '$s'!"):format(to))
				
				return true
			else
				minetest.chat_send_player(name, modCorreio.translate("There was an error sending your message!!!"))
			end
		else
			minetest.chat_send_player(name,modCorreio.translate("/mail [<playername> <message>]: Sends email to a player"))
		end
	end
	return false
end

modCorreio.set_broadcast = function(namefrom, message)
	local tblPlayers = modsavevars.getAllDBChars()
	if type(tblPlayers[namefrom])~="table" then tblPlayers[namefrom]={} end

	local contsend = 0
	if tblPlayers~=nil and type(tblPlayers)=="table" then
		for nameto, _ in pairs(tblPlayers) do 
			local last_login = modsavevars.getCharValue(nameto, "last_login")
			if last_login~=nil and last_login~="" and last_login < os.time() + (60*60*24*30) then --30 dias
				local mens = modCorreio.set_mail(namefrom, nameto, message)
				if mens~=nil then
					contsend = contsend + 1
				end
			end
		end
	end
	return contsend
end

modCorreio.chat_broadcast = function(name, param) --Usado apenas por comando de chat
	if name~=nil and type(name)=="string" and name~="" then
		player = minetest.get_player_by_name(name)
		if player~=nil and player:is_player() then --Verifica se o player ainda esta online
			if param~=nil and type(param)=="string" and param~="" then
				local contsend = modCorreio.set_broadcast(name, param)
				if contsend>=1 then
					--minetest.sound_play("sfx_alertfire", {object=player, max_hear_distance = 1000})  
					minetest.chat_send_player(name,modCorreio.translate("Your letter was sent to '%02d' players"):format(contsend))
					
				else
					minetest.chat_send_player(name,modCorreio.translate("This letter was not sent to any player"))
				end
				return contsend
			else
				minetest.chat_send_player(name,modCorreio.translate("/broadcast <message>: Sends letters to all registered players"))
			end
		end
	end
end

function fixUTF8(s, replacement)
  local p, len, invalid = 1, #s, {}
  while p <= len do
    if     p == s:find("[%z\1-\127]", p) then p = p + 1
    elseif p == s:find("[\194-\223][\128-\191]", p) then p = p + 2
    elseif p == s:find(       "\224[\160-\191][\128-\191]", p)
        or p == s:find("[\225-\236][\128-\191][\128-\191]", p)
        or p == s:find(       "\237[\128-\159][\128-\191]", p)
        or p == s:find("[\238-\239][\128-\191][\128-\191]", p) then p = p + 3
    elseif p == s:find(       "\240[\144-\191][\128-\191][\128-\191]", p)
        or p == s:find("[\241-\243][\128-\191][\128-\191][\128-\191]", p)
        or p == s:find(       "\244[\128-\143][\128-\191][\128-\191]", p) then p = p + 4
    else
      s = s:sub(1, p-1)..replacement..s:sub(p+1)
      table.insert(invalid, p)
    end
  end
  return s, invalid
end

modCorreio.regulechars = function(text)
	text = text:gsub("\r", "")

	text = text:gsub("[Â]", "A")
	text = text:gsub("[Ä]", "A")
	text = text:gsub("[Ã]", "A")
	text = text:gsub("[Á]", "A")
	text = text:gsub("[À]", "A")
	text = text:gsub("[Ê]", "E")
	text = text:gsub("[Ë]", "E")
	text = text:gsub("[Ẽ]", "E")
	text = text:gsub("[É]", "E")
	text = text:gsub("[È]", "E")
	text = text:gsub("[Î]", "I")
	text = text:gsub("[Ï]", "I")
	text = text:gsub("[Ĩ]", "I")
	text = text:gsub("[Í]", "I")
	text = text:gsub("[Ì]", "I")
	text = text:gsub("[Ô]", "O")
	text = text:gsub("[Ö]", "O")
	text = text:gsub("[Õ]", "O")
	text = text:gsub("[Ó]", "O")
	text = text:gsub("[Ò]", "O")
	text = text:gsub("[Û]", "U")
	text = text:gsub("[Ü]", "U")
	text = text:gsub("[Ũ]", "U")
	text = text:gsub("[Ú]", "U")
	text = text:gsub("[Ù]", "U")
	text = text:gsub("[Ç]", "C")
	
	text = text:gsub("[â]", "a")
	text = text:gsub("[ä]", "a")
	text = text:gsub("[ã]", "a")
	text = text:gsub("[á]", "a")
	text = text:gsub("[à]", "a")
	text = text:gsub("[ê]", "e")
	text = text:gsub("[ë]", "e")
	text = text:gsub("[ẽ]", "e")
	text = text:gsub("[é]", "e")
	text = text:gsub("[è]", "e")
	text = text:gsub("[î]", "i")
	text = text:gsub("[ï]", "i")
	text = text:gsub("[ĩ]", "i")
	text = text:gsub("[í]", "i")
	text = text:gsub("[ì]", "i")
	text = text:gsub("[ô]", "o")
	text = text:gsub("[ö]", "o")
	text = text:gsub("[õ]", "o")
	text = text:gsub("[ó]", "o")
	text = text:gsub("[ò]", "o")
	text = text:gsub("[û]", "u")
	text = text:gsub("[ü]", "u")
	text = text:gsub("[ũ]", "u")
	text = text:gsub("[ú]", "u")
	text = text:gsub("[ù]", "u")
	text = text:gsub("[ç]", "c")

	
	return text
end


modCorreio.get_mails = function(playername)
	local tblCorreio=modCorreio.getDataBase(playername)
	if type(tblCorreio)=="table" and type(tblCorreio.messages)=="table" then
		return tblCorreio.messages
	end
	return {}
end

modCorreio.get_mail = function(playername, mailnumber)
	if type(playername)=="string" and playername~="" and type(mailnumber)=="number" and mailnumber>=1 then
		local tblCorreio=modCorreio.getDataBase(playername)
		if #tblCorreio.messages >= 1 and tblCorreio.messages[mailnumber]~=nil then
			return tblCorreio.messages[mailnumber]
		end
	end
end

modCorreio.get_formspecmails = function(playername)
	local formspeclist = ""
	if type(playername)=="string" and playername~="" then
		local mails = modCorreio.get_mails(playername)
		if mails~=nil and type(mails)=="table" and #mails>=1 then
			for n, mail in pairs(mails) do 
				local mensagem = mail.message:gsub("[\n]", " ")
				mensagem = modCorreio.regulechars(mensagem)
				
				if mail.readed == true then
					formspeclist = formspeclist .. minetest.formspec_escape(os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time).." [X] <"..mail.namefrom.."> ".. modCorreio.regulechars(mensagem))
				else
					formspeclist = formspeclist .. minetest.formspec_escape(os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time).." [  ] <"..mail.namefrom.."> ".. modCorreio.regulechars(mensagem))
				end
				if n < #mails then
					formspeclist = formspeclist .. ","
				end
			end
		end
	end
	return formspeclist
end


modCorreio.chat_readmail = function(name) --Usado apenas por comando de chat
	if name~=nil and type(name)=="string" and name~="" then
		local player = minetest.get_player_by_name(name)
		if player~=nil and player:is_player() then --Verifica se o player ainda esta online
			local mails = modCorreio.get_mails(name)
			if mails~=nil and type(mails)=="table" and #mails>=1 then
				for n, mail in pairs(mails) do 
					if mail.readed == true then
						minetest.chat_send_player(name, os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time) .." [X] <"..mail.namefrom.."> ".. modCorreio.regulechars(mail.message))
					else
						minetest.chat_send_player(name, os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time) .." [  ] <"..mail.namefrom.."> ".. modCorreio.regulechars(mail.message))
					end
					modCorreio.set_read(name, n, true)
				end
				
				return #mails
			else
				minetest.chat_send_player(name, modCorreio.translate("You have no letters..."))
				return 0
			end
		end
	end
	return false
end

modCorreio.del_mail = function(playername, mailnumber)
	if type(playername)=="string" and playername~="" and type(mailnumber)=="number" and mailnumber>=1 then
		local tblCorreio=modCorreio.getDataBase(playername)
		if #tblCorreio.messages >= 1 and type(tblCorreio.messages[mailnumber])=="table" then
			table.remove(tblCorreio.messages, mailnumber)
			modCorreio.setDataBase(playername, tblCorreio)
			modCorreio.hud_print(playername)
			return true
		end
	end
	return false
end

modCorreio.del_readeds = function(playername) --Bugado
	if type(playername)=="string" and playername~="" then
		local mails = modCorreio.getDataBase(playername).messages
		if type(mails)=="table" then
			local countdel = 0
			if #mails>=1 then
				for n, mail in pairs(mails) do 
					if mail.readed == true then
						if modCorreio.del_mail(playername, n)==true then
							countdel = countdel + 1
						end
					end
				end
			end
			return countdel
		end
	end
end

modCorreio.chat_delreadeds = function(playername) --Usado apenas por comando de chat
	if playername~=nil and type(playername)=="string" and playername~="" then
		player = minetest.get_player_by_name(playername)
		if player~=nil and player:is_player() then --Verifica se o player ainda esta online
			local apagados = modCorreio.del_readeds(playername)
			if apagados~=nil and type(apagados)=="number" then
				if apagados>=1 then
					minetest.chat_send_player(playername, modCorreio.translate("Letters Destroyed")..": "..apagados)
					
				else
					minetest.chat_send_player(playername, modCorreio.translate("You have no letter readed to destroy"))
				end
			else
				minetest.chat_send_player(playername, "[ERRO] "..modCorreio.translate("There was an error deleting your letters"))
			end
			return apagados
		end
	end
end

modCorreio.get_countunreaded = function(playername)
	if type(playername)=="string" and playername~="" then
		local mails = modCorreio.getDataBase(playername).messages
		local myCount = 0
		if type(mails)=="table" and #mails>=1 then
			for n, mail in pairs(mails) do 
				if mail.readed ~= true then
					myCount = myCount +1
				end
			end
		end
		return myCount
	end
end


modCorreio.del_olds = function()
	local tblPlayers = modsavevars.getAllDBChars()
	if type(tblPlayers)=="table" then
		local countdels = 0
		local now = os.time()
		for playername, _ in pairs(tblPlayers) do 
			local tblCorreio=modCorreio.getDataBase(playername)
			if type(tblCorreio.messages)=="table" and #tblCorreio.messages>=1 then
				local newMailLote = {}
				for n, mail in pairs(mails) do 
					if now <= mail.time + (60*60*24*modCorreio.max_days_validate)  then
						table.insert(newMailLote,mail)
					else
						--print("######## Apagando carta nº"..n.." de "..dump(os.date("%Y-%m-%d %Hh:%Mm:%Ss", mail.time)).." que pertence a '"..playername.."'!")
						countdels = countdels + 1
					end
				end
				tblCorreio.messages = newMailLote
				modCorreio.setDataBase(playername,tblCorreio)
			end
		end
		modsavevars.doSave()
		return countdels
	end
end

modCorreio.chat_delolds = function(playername) --Usado apenas por comando de chat
	if type(playername)=="string" and playername~="" then
		local player = minetest.get_player_by_name(playername)
		if player~=nil and player:is_player() then --Verifica se o player ainda esta online
			local contdels = modCorreio.del_olds()
			if contdels~=nil and type(contdels)=="number" then
				if contdels>=1 then
					minetest.chat_send_player(playername, "[CORREIO] "..
					modCorreio.translate("The total of %02d letters with a deadline above %02d days have been deleted on the server"):format(contdels,modCorreio.max_days_validate))
				else
					minetest.chat_send_player(playername,"[CORREIO] "..modCorreio.translate("No letter with deadline above %02d days was deleted"):format(modCorreio.max_days_validate))
				end
				return contdels
			else
				minetest.chat_send_player(playername,"[ERRO: modCorreio.chat_delolds(playername)] "..modCorreio.translate("There was an error deleting all the '%s' old emails"):format(dump(contdels)))
			end
		end
	end
end


modCorreio.set_read = function(playername, mailnumber, value)
	if type(playername)=="string" and playername~="" then
		if type(mailnumber)=="number" and mailnumber>=1 then
			if type(value)=="boolean" then
				local tblPlayer=modCorreio.getDataBase(playername)
				if #tblPlayer.messages >= 1 and mailnumber <= #tblPlayer.messages then
					tblPlayer.messages[mailnumber].readed = value
					modCorreio.setDataBase(playername, tblPlayer)
					return true
				end
			end
		end
	end
end

modCorreio.hud_print = function(player)
	if player~=nil and type(player)=="string" and player~="" then --Caso a variavel "player" seja fornecido no formato "string"
		player = minetest.get_player_by_name(player)
	end
	
	if player~=nil and player:is_player() then
		local playername = player:get_player_name()

		if modCorreio.huds[playername]==nil then
			modCorreio.huds[playername] ={}
		end
		
		if modCorreio.huds[playername].image then
			player:hud_remove(modCorreio.huds[playername].image)
		end
		if modCorreio.huds[playername].text1 then
			player:hud_remove(modCorreio.huds[playername].text1)
		end

		
		local unreadeds = modCorreio.get_countunreaded(playername)
		if unreadeds~=nil and type(unreadeds)=="number" and unreadeds>=1 then
			local mensagem=modCorreio.translate("You have %02d unread emails \nin your mailbox!"):format(unreadeds)
			
			modCorreio.huds[playername].image = player:hud_add({
				hud_elem_type = "image",
				--name = "MailIcon",
				position = {x=0.71, y=0.45}, --{x=0.51, y=0.45},
				text="icon_mail2.png",
				scale = {x=1,y=1},
				alignment = {x=0.5, y=0.5},
			})	
			modCorreio.huds[playername].text1 = player:hud_add({
				hud_elem_type = "text",
				--name = "MailText",
				number = 0xFFFFFF,
				position = {x=0.81, y=0.49}, --{x=0.71, y=0.56},
				text=mensagem,
				scale = {x=1,y=1},
				alignment = {x=0.5, y=0.5},
			})
		end -- fim de if unreadeds~=nil then
	end -- fim de if player~=nil and player:is_player() then
end

modCorreio.hud_check = function()
	local players = minetest.get_connected_players()
	if #players >= 1 then
		if 
			modCorreio.hud_time~=nil and modCorreio.hud_delay~=nil and 
			type(modCorreio.hud_time)=="number" and type(modCorreio.hud_delay)=="number" and 
			modCorreio.hud_time + modCorreio.hud_delay < os.time() 
		then
			modCorreio.hud_time = os.time()
			for _, player in ipairs(players) do
				modCorreio.hud_print(player)
			end
		end
	end
end

--##################################################################################

modCorreio.getPropCommBroadcast = function(nameCommand)
   return {
      privs = {postman=true},
      params = "<".. modCorreio.translate("message")..">",
      description = "/"..nameCommand.." <".. modCorreio.translate("message").."> : "..modCorreio.translate("Send email to all registered players."),
      func = function(name, param)
         modCorreio.chat_broadcast(name, param)
      end,
   }
end

modCorreio.getPropCommDeleteOldMails = function(nameCommand)
   return {
      privs = {postman=true},
      params = "",
      description = "/"..nameCommand.." : "..modCorreio.translate("Delete emails older than thirty days on the entire server."),
      func = function(playername, param)
         modCorreio.chat_delolds(playername)
      end,
   }
end

modCorreio.getPropCommSendMail = function(nameCommand)
   return {
      privs = {postman=true},
      params = "[<".. modCorreio.translate("playername").."> <".. modCorreio.translate("message")..">]",
      description = "/"..nameCommand.." <".. modCorreio.translate("playername").."> <".. modCorreio.translate("message").."> : ".. modCorreio.translate("Sends email to a specific player."),
      func = function(playername, param)
         if type(modCorreio.openpapermail)=="function" then
            modCorreio.openpapermail(playername)
         else
            modCorreio.chat_writemail(playername, param)
         end
      end,
   }
end

modCorreio.getPropCommShowMailBox = function(nameCommand)
   return {
      privs = {walkingreader=true},
      description = "/"..nameCommand.." : "..modCorreio.translate("Displays all of your inbox emails."),
      func = function(playername, param)
         if type(modCorreio.openinbox)=="function" then
            modCorreio.openinbox(playername)
         else
            modCorreio.chat_readmail(playername)
         end
      end,
   }
end

modCorreio.getPropCommDeleteReadMails = function(nameCommand)
   return {
      privs = {walkingreader=true},
      description = "/"..nameCommand.." : "..modCorreio.translate("Deletes all emails read from the player."),
      func = function(name, param)
         modCorreio.chat_delreadeds(name)
      end,
   }
end

--##################################################################################

minetest.register_globalstep(function(dtime)
	modCorreio.hud_check()
end)
