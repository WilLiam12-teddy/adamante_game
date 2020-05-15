minetest.register_privilege("savevars",  {
	description="Permite que o jogador edite variaveis por linha de comando.", 
	give_to_singleplayer=false,
})

if not (core.setting_getbool("savevars_log")~=true) then 
	core.setting_setbool("savevars_log", false)
	core.setting_save() 
end

modsavevars = { }
modsavevars.fileVariables = minetest.get_worldpath().."/variables.tbl"
modsavevars.variables={  global={}, players={} 	}
modsavevars.doOpen = function()
	local file = io.open(modsavevars.fileVariables, "r")
	if file then
		local table = minetest.deserialize(file:read("*all"))
		file:close()
		if type(table) == "table" then
			modsavevars.variables = table
			return
		end
		--minetest.log('action',"[SAVEVARS] doOpen("..modsavevars.fileVariables.."')")
		minetest.log('action',"[SAVEVARS] Abrindo '"..modsavevars.fileVariables.."' !")
		if core.setting_getbool("savevars_log") then 
			minetest.log('action',"doOpen("..modsavevars.fileVariables.."')") 
		end
	end
end
modsavevars.doSave = function()
	--file = io.open(modsavevars.fileVariables,"a+")
	local file = io.open(modsavevars.fileVariables,"w")
	if file then
		file:write(minetest.serialize(modsavevars.variables))
		file:close()
	else
		minetest.log('error',"[SAVEVARS:ERROR] Não foi possivel salvar o arquivo '"..modsavevars.fileVariables.."'!")
	end
end

modsavevars.getAllDBChars = function() --Criado para o mod 'correio'
	return modsavevars.variables.players
end
modsavevars.setAllDBChars = function(tblPlayers) --Criado para o mod 'correio'
	modsavevars.variables.players = tblPlayers
end

modsavevars.setGlobalValue = function(variavel, valor)
	if modsavevars.variables.global==nil then
		modsavevars.variables.global = {}
	end
	if valor~=nil or modsavevars.variables.global[variavel]~=nil then --Verifica se nao ja estava apagada
		if type(valor)=="number" then valor = valor * 1 end --para transformar em numero
		modsavevars.variables.global[variavel] = valor
		if core.setting_getbool("savevars_log") then
			if valor~= nil then
				minetest.log('action',"modsavevars.setGlobalValue("..variavel.."='"..dump(valor).."')")
			else
				minetest.log('action',"modsavevars.setGlobalValue("..variavel.."=nil)")
			end
		end
	end
	--modsavevars.doSave() --Salva quando desliga o server ou quando sai o jogador
end
modsavevars.getGlobalValue = function(variavel)
	if modsavevars.variables.global~=nil and modsavevars.variables.global[variavel]~=nil then
		local valor = modsavevars.variables.global[variavel]
		if core.setting_getbool("savevars_log") then
			minetest.log('action',"modsavevars.getGlobalValue("..variavel..") = '"..dump(valor).."'")
		end
		return valor
	end
	return nil
end
modsavevars.setCharValue = function(charName, variavel, valor)
	if modsavevars.variables.players[charName] == nil then
		modsavevars.variables.players[charName] = {}
	end
	if valor~=nil or modsavevars.variables.players[charName][variavel]~=nil then --Verifica se nao ja estava apagada
		modsavevars.variables.players[charName][variavel] = valor
		if core.setting_getbool("savevars_log") then
			if valor~= nil then
				minetest.log('action',"modsavevars.setCharValue("..charName..":"..variavel.."='"..dump(valor).."')")
			else
				minetest.log('action',"modsavevars.setCharValue("..charName..":"..variavel.."=nil)")
			end
		end
	end
	--modsavevars.doSave() --Salva quando desliga o server ou quando sai o jogador
end

modsavevars.getCharValue = function(charName, variavel)
	if modsavevars.variables.players[charName]~=nil and modsavevars.variables.players[charName][variavel]~=nil then
		local valor = modsavevars.variables.players[charName][variavel]
		if core.setting_getbool("savevars_log") then
			minetest.log('action',"modsavevars.getCharValue("..charName..":"..variavel..") = '"..dump(valor).."'")
		end
		return valor
	end
	return nil
end

modsavevars.register_on_prejoinplayer = function(playername, ip)
	local listed_ip = modsavevars.getCharValue(playername, "listed_ip")
	if listed_ip==nil or listed_ip=="" then
		listed_ip = ip
	elseif not string.find(listed_ip, ip) then
		listed_ip = listed_ip .. ";" .. ip
	end
	modsavevars.setCharValue(playername, "listed_ip", listed_ip)
	modsavevars.setCharValue(playername, "last_ip", ip)
	modsavevars.setCharValue(playername, "last_login", os.time())
	modsavevars.doSave()
end

modsavevars.register_on_leaveplayer = function(playername)
	local last_login = tonumber(modsavevars.getCharValue(playername, "last_login"))
	local last_logout = tonumber(os.time())
	local time_played = tonumber(modsavevars.getCharValue(playername, "time_played") or 0) + (last_logout - last_login)

	minetest.log('action',"The player '"..playername.."' did leave after "..time_played.." seconds of game.")
	
	modsavevars.setCharValue(playername, "last_logout", last_logout)
	modsavevars.setCharValue(playername, "time_played", time_played)
	modsavevars.doSave()
end

modsavevars.register_on_shutdown = function()
	local players_online = minetest.get_connected_players()
if players_online ~= nil then
for _,player in ipairs(players_online) do
		local playername = player:get_player_name()
		modsavevars.register_on_leaveplayer(playername)
	end
end
	modsavevars.doSave()
	minetest.log('action',"[SAVEVARS] Salvando banco de dados de todos os jogadores em '"..modsavevars.fileVariables.."' !")
end

--######################################################################################################################

minetest.register_on_prejoinplayer(function(playername, ip)
	modsavevars.register_on_prejoinplayer(playername, ip)
end)

minetest.register_on_leaveplayer(function(player)
	modsavevars.register_on_leaveplayer(player:get_player_name())
end)

minetest.register_on_shutdown(function()
	modsavevars.register_on_shutdown()
end)

--######################################################################################################################

modsavevars.doOpen()
