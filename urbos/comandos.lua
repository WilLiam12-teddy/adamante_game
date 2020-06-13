--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Comandos
  ]]

-- Caminho do diretório do mundo
local worldpath = minetest.get_worldpath()

-- Pegar dono do quadrado atual
local get_owner_area = function(pos)
	local current_owner = ""
	local data = s_protect.get_claim(pos)
	if data then
		current_owner = data.owner
	end
	return current_owner
end

-- Comando
minetest.register_chatcommand("urbos", {
	privs = {server=true},
	params = "[save|Salva o centro de cidade atual como padrao]",
	description = "Gerenciamente de cidades",
	func = function(name, param)
		
		-- Salvar estrutura de centro de cidade padrão
		if param == "save" then
			local player = minetest.get_player_by_name(name)
			
			-- Verificar cidade atual
			local o = get_owner_area(player:getpos())
			local c = ""
			if o ~= "" and string.find(o, "Cidade:") then
				c = string.gsub(o, "Cidade:", "")
			else
				minetest.chat_send_player(name, "Precisa estar em um centro de cidade")
			end
			
			local pos = urbos.bd.pegar("cidades", c).pos
			
			-- Pegar area de spawn da cidade
			local minp, maxp = s_protect.get_area_bounds(pos)
			
			minetest.create_schematic(
				{x=minp.x, y=pos.y-4, z=minp.z}, 
				{x=maxp.x, y=pos.y+15, z=maxp.z}, 
				{}, worldpath.."/urbos_default_center.mts", nil)

			minetest.chat_send_player(name, "Modelo de centro de cidade salvo. Precisa reiniciar mundo para efetivar modelo.")
			
		end
		
	end
})
