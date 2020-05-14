libSaveLogs.doSave = function()
	if libSaveLogs.txtIncrease~="" then
		local fileName = "log_"..os.date("%Y-%m-%d")..".txt"
		local logFile = minetest.get_worldpath().."/"..fileName
		if type(libSaveLogs.savePath)=="string" and libSaveLogs.savePath~="" then logFile = libSaveLogs.savePath.."/"..fileName end
		local file = io.open(logFile,"a+") --Registra no final do arquivo!!!
		if file then
			file:write(libSaveLogs.txtIncrease)
			file:flush() --<= Nao sei se esta linha esta ajudando!!!
			file:close()
			libSaveLogs.txtIncrease = ""
		else
			minetest.log('error',"[LIB_SAVELOGS] Nao foi possivel abrir o arquivo '"..logFile.."'!")
		end
	end
end

libSaveLogs.getPosResumed = function(pos)
	if pos and pos.x and pos.y and pos.z then
		local newPos = pos
		newPos.x = math.floor(newPos.x)
		newPos.y = math.floor(newPos.y)
		newPos.z = math.floor(newPos.z)
		return newPos
	end
	return pos	
end

libSaveLogs.addLog = function(message, noTime)
	if type(message)=="string" and message~="" then
		if type(libSaveLogs.txtIncrease)~="string" then 
			libSaveLogs.txtIncrease=""	
		end
		
		if type(noTime)=="boolean" and noTime==true then
			libSaveLogs.txtIncrease = libSaveLogs.txtIncrease .. "\n"..message
		else
			libSaveLogs.txtIncrease = libSaveLogs.txtIncrease .. "\n"..os.date("%Hh:%Mm:%Ss").." "..message
		end
	end
end

minetest.register_globalstep(function(dtime)
	if type(libSaveLogs.timeLeft)~="number" then	libSaveLogs.timeLeft=0 end
	if libSaveLogs.timeLeft <= 0 then
		libSaveLogs.timeLeft = libSaveLogs.timeLeft + libSaveLogs.saveInterval
		libSaveLogs.doSave()
	else
		libSaveLogs.timeLeft = libSaveLogs.timeLeft - dtime
	end
end)

minetest.register_on_joinplayer(function(player)
	if type(libSaveLogs.savePosOfSpeaker)=="boolean" and libSaveLogs.savePosOfSpeaker==true  then
		libSaveLogs.addLog("<server:login> "..player:get_player_name().." entrou no servidor! "..minetest.pos_to_string(libSaveLogs.getPosResumed(player:getpos())))
	else
		libSaveLogs.addLog("<server:login> "..player:get_player_name().." entrou no servidor!")
	end
	libSaveLogs.doSave()
end)

minetest.register_on_leaveplayer(function(player)
	if type(libSaveLogs.savePosOfSpeaker)=="boolean" and libSaveLogs.savePosOfSpeaker==true  then
		libSaveLogs.addLog("<server:logout> "..player:get_player_name().." saiu do servidor! "..minetest.pos_to_string(libSaveLogs.getPosResumed(player:getpos())))
	else
		libSaveLogs.addLog("<server:logout> "..player:get_player_name().." saiu do servidor!")
	end
	libSaveLogs.doSave()
end)

minetest.register_on_shutdown(function()
	libSaveLogs.addLog("<server:shutdown> O servidor desligou!")
	libSaveLogs.doSave()
end)

libSaveLogs.addLog("--------------------------------------------------------------------------------------------------------------", true)
libSaveLogs.addLog("<server:activate> O servidor recem ativado!")
