--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	MapGen
	
  ]]

local modpath = minetest.get_modpath("taverna_barbara")

-- converter para numero
local pnum = function(n)
	if n == nil or n == false then
		return 0
	else
		return tonumber(n)
	end
end

-- Pegar node
local function pegar_node(pos)
	local node = minetest.get_node(pos)
	if node.name == "ignore" then
		minetest.get_voxel_manip():read_from_map(pos, pos)
		node = minetest.get_node(pos)
	end
	return node
end

-- Pegar altura de referencia de uma coluda de blocos
local pegar_altura_solo = function(pos)
	local y = pos.y + 39
	local resp = false
	while y >= pos.y - 39 and y > 0 do
		local node = pegar_node({x=pos.x,y=y,z=pos.z})
		if node.name == "default:dirt_with_grass"
			or node.name == "default:dirt_with_snow"
			or node.name == "default:snowblock"
			or node.name == "default:dirt"
		then
			resp = y
			break
		end
		y = y - 1
	end
	return resp
end

-- Calcular maior
local solos_aceitaveis = {"default:dirt_with_grass", "default:snowblock", "default:dirt_with_snow"}
minetest.register_on_generated(function(minp, maxp, seed)
	--[[ 
		Verificar se o local gerado pode ter arvore 
		(deve ser um algoritimo rapido e muito leve 
		devido a sua repetição extrema)
	]]
	
	
	-- verifica se está na faixa desejada de altura no mapa
	if maxp.y < 10 or minp.y > 90 then return end
	
	-- centro
	local cp = vector.add(minp, 40)
	
	-- carregar mapa na memoria
	if minetest.get_voxel_manip():read_from_map(minp, maxp) then end
	
	
	-- verifica se tem terra com grama ou neve
	local pos_ref = minetest.find_node_near(cp, 40, {"default:dirt_with_grass" , "default:snowblock"})
	if pos_ref == nil then return end
	
	-- Sortear (apenas diminui a ocorrencia antes dos cálculos)
	if math.random(1, 100) > taverna_barbara.probabilidade_gen then return end
	
	
	--[[
		Mapear uma malha uniforme em todo o bloco gerado
			* 13 blocos de distancia entre cada nó da malha
	  ]]
	  
	-- Criando malha
	local malha = {}
	for x=1, 5 do
		malha[x] = {}
		for z=1, 5 do
			malha[x][z] = {}
		end
	end
	
	-- Pegando coordenadas reais dos nós da malha
	for x=1, 5 do
		local xreal = minp.x + (x-1)*13
		for z=1, 5 do
			malha[x][z].x = xreal
			malha[x][z].z = minp.z + (z-1)*13
		end
	end
	
	
	-- Pegando altura do solo em cada nó da malha
	for x=1, 5 do
		for z=1, 5 do
			malha[x][z].y = pegar_altura_solo({x=malha[x][z].x,y=0,z=malha[x][z].z})
			local node = pegar_node({x=malha[x][z].x,y=0,z=malha[x][z].z})
			malha[x][z].solo = node.name
		end
	end
	
	
	-- Pegando variação entre nós vizinhos (operação não ocorre em nós de borda)
	for x=2, 4 do
		for z=2, 4 do
			malha[x][z].q = 0
			local n = false
			local min, max = false, false
			
			if malha[x][z].y then
				if max == false then max = malha[x][z].y end
				if min == false then min = malha[x][z].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x][z].y
				if pnum(min) > malha[x][z].y then
					min = malha[x][z].y
				end
				if pnum(max) < malha[x][z].y then
					max = malha[x][z].y
				end
			end
			if malha[x+1][z].y then
				if max == false then max = malha[x+1][z].y end
				if min == false then min = malha[x+1][z].y end 
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x+1][z].y
				if pnum(min) > malha[x+1][z].y then
					min = malha[x+1][z].y
				end
				if pnum(max) < malha[x+1][z].y then
					max = malha[x+1][z].y
				end
			end
			if malha[x-1][z].y then 
				if max == false then max = malha[x-1][z].y end
				if min == false then min = malha[x-1][z].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x-1][z].y
				if pnum(min) > malha[x-1][z].y then
					min = malha[x-1][z].y
				end
				if pnum(max) < malha[x-1][z].y then
					max = malha[x-1][z].y
				end
			end
			if malha[x][z+1].y then 
				if max == false then max = malha[x][z+1].y end
				if min == false then min = malha[x][z+1].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x][z+1].y
				if pnum(min) > malha[x][z+1].y then
					min = malha[x][z+1].y
				end
				if pnum(max) < malha[x][z+1].y then
					max = malha[x][z+1].y
				end
			end
			if malha[x+1][z+1].y then 
				if max == false then max = malha[x+1][z+1].y end
				if min == false then min = malha[x+1][z+1].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x+1][z+1].y
				if pnum(min) > malha[x+1][z+1].y then
					min = malha[x+1][z+1].y
				end
				if pnum(max) < malha[x+1][z+1].y then
					max = malha[x+1][z+1].y
				end
			end
			if malha[x-1][z+1].y then 
				if max == false then max = malha[x-1][z+1].y end
				if min == false then min = malha[x-1][z+1].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x-1][z+1].y
				if pnum(min) > malha[x-1][z+1].y then
					min = malha[x-1][z+1].y
				end
				if pnum(max) < malha[x-1][z+1].y then
					max = malha[x-1][z+1].y
				end
			end
			if malha[x][z-1].y then 
				if max == false then max = malha[x][z-1].y end
				if min == false then min = malha[x][z-1].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x][z-1].y
				if pnum(min) > malha[x][z-1].y then
					min = malha[x][z-1].y
				end
				if pnum(max) < malha[x][z-1].y then
					max = malha[x][z-1].y
				end
			end
			if malha[x+1][z-1].y then 
				if max == false then max = malha[x+1][z-1].y end
				if min == false then min = malha[x+1][z-1].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x+1][z-1].y
				if pnum(min) > malha[x+1][z-1].y then
					min = malha[x+1][z-1].y
				end
				if pnum(max) < malha[x+1][z-1].y then
					max = malha[x+1][z-1].y
				end
			end
			if malha[x-1][z-1].y then 
				if max == false then max = malha[x-1][z-1].y end
				if min == false then min = malha[x-1][z-1].y end
				malha[x][z].q = malha[x][z].q + 1
				if n == false then n = 0 end
				n = pnum(n) + malha[x-1][z-1].y
				if pnum(min) > malha[x-1][z-1].y then
					min = malha[x-1][z-1].y
				end
				if pnum(max) < malha[x-1][z-1].y then
					max = malha[x-1][z-1].y
				end
			end
			malha[x][z].min = min
			malha[x][z].max = max
			malha[x][z].y = max
			if min and max then
				malha[x][z].amp = math.abs(max - min)
			else
				malha[x][z].amp = false
			end
			if n and malha[x][z].q then
				malha[x][z].media = n/malha[x][z].q
			else
				malha[x][z].media = false
			end
			
			if malha[x][z].y == false and max then malha[x][z].y = max end
			if malha[x][z].y == false then malha[x][z].amp = false end
			
			-- verificar se ao menos os 4 nós de esquina estão corretos
			if malha[x+1][z+1].y == false
				or malha[x+1][z-1].y == false
				or malha[x-1][z-1].y == false
				or malha[x-1][z+1].y == false
			then
				malha[x][z].amp = false
			end
			
		end
	end
	
	-- Separar a menor amplitude e sua coordenada (sem agua perto)
	local menor_amp = false
	local pos = {}
	for x=2, 4 do
		for z=2, 4 do
			if malha[x][z].amp then
				local npos = {x=malha[x][z].x, y=malha[x][z].y, z=malha[x][z].z}
				if minetest.find_node_near(npos, 10, {"default:water"}) == nil then
					if menor_amp == false then 
						menor_amp = malha[x][z].amp
						pos = npos
					end
					if malha[x][z].amp < menor_amp then
						menor_amp = malha[x][z].amp
						pos = npos
					end
				end
			end
		end
	end
	
	
	-- Verificar se a menor amplitude está dentro do limite aceito e se ela existe
	if menor_amp == false or menor_amp > 5 then return end
	
	-- Pegar um bloco exemplar do tipo de solo do local
	local pos_ref = minetest.find_node_near(pos, 20, solos_aceitaveis)
	if not pos_ref then 
		return false
	end
	local node = pegar_node(pos_ref)
	
	
	local d_area = 7+6 -- distancio do centro a borda da zona afetada (incluindo escadarias)
	local a_area = 15+2 -- distancio da altura do centro ao topo da zona afetada (acaba sendo as escadas ou o predio, depende do maior)
	if minetest.is_protected({x=pos.x+d_area, y=pos.y-7, z=pos.z+d_area}, "singleplayer") == true -- Baixo
			or minetest.is_protected({x=pos.x+d_area, y=pos.y-7, z=pos.z}, "singleplayer") == true
			or minetest.is_protected({x=pos.x+d_area, y=pos.y-7, z=pos.z-d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x, y=pos.y-7, z=pos.z+d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x, y=pos.y-7, z=pos.z}, "singleplayer") == true
			or minetest.is_protected({x=pos.x, y=pos.y-7, z=pos.z-d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x-d_area, y=pos.y-7, z=pos.z+d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x-d_area, y=pos.y-7, z=pos.z}, "singleplayer") == true
			or minetest.is_protected({x=pos.x-d_area, y=pos.y-7, z=pos.z-d_area}, "singleplayer") == true
			-- Alto
			or minetest.is_protected({x=pos.x+d_area, y=pos.y+a_area, z=pos.z+d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x+d_area, y=pos.y+a_area, z=pos.z}, "singleplayer") == true
			or minetest.is_protected({x=pos.x+d_area, y=pos.y+a_area, z=pos.z-d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x, y=pos.y+a_area, z=pos.z+d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x, y=pos.y+a_area, z=pos.z}, "singleplayer") == true
			or minetest.is_protected({x=pos.x, y=pos.y+a_area, z=pos.z-d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x-d_area, y=pos.y+a_area, z=pos.z+d_area}, "singleplayer") == true
			or minetest.is_protected({x=pos.x-d_area, y=pos.y+a_area, z=pos.z}, "singleplayer") == true
			or minetest.is_protected({x=pos.x-d_area, y=pos.y+a_area, z=pos.z-d_area}, "singleplayer") == true
	then
		return false
	end
	
	-- Planificar area
	if taverna_barbara.plagen.planificar(pos, "quadrada", 13, 40, {solo=node.name, subsolo="default:dirt", rocha="default:stone"}, 6, true, true) == false then 
		return false
	end
	
	pos.y = pegar_altura_solo(pos)
	
	-- Proteger area
	taverna_barbara.proteger_area(
		"Taverna_Barbara:Taverna", 
		"Taverna Barbara", 
		{x=pos.x-20, y=pos.y-15, z=pos.z-20}, 
		{x=pos.x+20, y=pos.y+2000, z=pos.z+20}, 
		true
	)
	
	-- Montar taverna
	local numero_arquivo = math.random(1, taverna_barbara.qtd_arquivos)
	minetest.place_schematic({x=pos.x-6,y=pos.y,z=pos.z-6}, modpath.."/estruturas/taverna_barbara_"..numero_arquivo..".mts", nil, nil, true)
	
	-- Fundamento
	minetest.set_node(pos, {name="taverna_barbara:fundamento"})
	local meta = minetest.get_meta(pos)
	meta:set_string("versao", taverna_barbara.versao)
	meta:set_string("numero_schem", numero_arquivo)
	
	return true
	
end)
