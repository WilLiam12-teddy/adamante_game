--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Criar uma cidade
  ]]
  
-- Caminho do diretório do mundo
local worldpath = minetest.get_worldpath()

-- Verifica se ja tem o arquivo de estrutura de centro
local status_file = false
local verificar_modelo = function()
	if status_file == true then return true end
	local entrada = io.open(worldpath.."/urbos_default_center.mts", "r")
	if entrada then
		io.close(entrada)
		status_file = true
		return true
	end
	return false
end

-- Abrir interface onde um jogador estiver
urbos.criar_cidade = function(player, nome_cidade)
	
	local pos = player:getpos()
	
	-- Proteger area
	local data, index = s_protect.get_claim({
		x = pos.x,
		y = pos.y,
		z = pos.z
	})
	data = {
		owner = "Cidade:"..nome_cidade,
		shared = {}
	}
	s_protect.set_claim(data, index)
	
	-- Pegar area de spawn da cidade
	local minp, maxp = s_protect.get_area_bounds(pos)
	
	-- Cria o solo da cidade
	for x=minp.x, maxp.x do
		for z=minp.z, maxp.z do
			for y=pos.y-8, pos.y+10 do
				if y > pos.y-1 then
					minetest.remove_node({x=x, y=y, z=z})
				else
					minetest.set_node({x=x, y=y, z=z}, {name="default:dirt"})
				end
			end
		end
	end
	
	-- Calcula spawn da cidade
	local pos_spawn = {x=((maxp.x-minp.x)/2)+minp.x, y=pos.y+3, z=((maxp.z-minp.z)/2)+minp.z}
	
	-- Constroi estrutura
	if verificar_modelo() == true then
		minetest.place_schematic({x=minp.x, y=pos_spawn.y-4, z=minp.z},	worldpath.."/urbos_default_center.mts", 0, {}, true)
	else
		minetest.place_schematic({x=minp.x, y=pos_spawn.y-4, z=minp.z},	minetest.get_modpath("urbos").."/urbos_default_center.mts", 0, {}, true)
	end
	player:setpos(pos_spawn)
	
	-- Encontra nodes de teleportador
	do
		local nodes = minetest.find_nodes_in_area(
			{x=minp.x, y=pos_spawn.y-4, z=minp.z}, 
			{x=maxp.x, y=pos_spawn.y+10, z=maxp.z}, 
			{"urbos:teleportador"}
		)
		for _,p in ipairs(nodes) do
			minetest.registered_nodes["urbos:teleportador"].on_construct(p)
		end
	end
	
	-- Registra no banco de dados
	urbos.nova_cidade(nome_cidade, pos_spawn)
	
	-- Analisa pontos para o rank
	urbos.analisar_cidade(nome_cidade)
	
end

