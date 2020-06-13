--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Teleportador para viajar entre as cidades
  ]]

-- Pegar dono do quadrado atual
local get_owner_area = function(pos)
	local current_owner = ""
	local data = s_protect.get_claim(pos)
	if data then
		current_owner = data.owner
	end
	return current_owner
end

-- Acessar interface
local exibir_interface_teleportador = function(name)
	local player = minetest.get_player_by_name(name)
	
	-- Montar string de lista
	local my_c = player:get_attribute("urbos_cidade") -- cidade marcada
	local st_list = my_c or "" -- primeiro a cidade marcada
	local rank = {} -- Rank visto
	if my_c then table.insert(rank, my_c) end
	for _,d in pairs(urbos.get_rank()) do
		if d.name ~= my_c then
			if d.pontos > 0 then
				table.insert(rank, d.name)
				if st_list ~= "" then st_list = st_list .. "," end
				st_list = st_list .. d.name
			end
		end
	end
	-- Salva lista visualizada
	player:set_attribute("urbos_rank_visto", minetest.serialize(rank))
	
	-- Formspec
	local formspec = "size[6,7]"
		..default.gui_bg
		..default.gui_bg_img
		
		.."label[1,0.1;Cidades Recomendadas]"
		.."textlist[0.9,0.6;4,4.3;list;"..st_list..";]"
		
		.."field[0.4,6.4;3.2,1;nome_cidade;Pesquisar Cidade;]"
		.."button_exit[3.3,6.1;2.6,1;pesquisar;Pesquisar]"
	
	-- Verificar cidade atual
	local o = get_owner_area(player:getpos())
	if o ~= "" and string.find(o, "Cidade:") then
		local c = string.gsub(o, "Cidade:", "")
		formspec = formspec.."checkbox[1,4.8;marcar;Marcar "..c..";"..tostring(c==player:get_attribute("urbos_cidade")).."]"
		-- Salva cidade visualizada
		player:set_attribute("urbos_cidade_vista", c)
	end
	
	-- Exibe regras
	minetest.show_formspec(name, "urbos:cidades", formspec)
end

-- Reber botoes
minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname == "urbos:cidades" then
		local name = player:get_player_name()
		
		-- Caso viajou para uma cidade
		if fields.list then
			local n = string.split(fields.list, ":")
			if n[1] == "DCL" then
				local rank = minetest.deserialize(player:get_attribute("urbos_rank_visto"))
				if rank[1] then
					player:setpos(urbos.bd.pegar("cidades", rank[tonumber(n[2])]).pos)
					-- Fecha formspec
					minetest.close_formspec(name, formname)
				end
				
			end
		
		-- Marcar/Desmarcar cidade
		elseif fields.marcar then
			
			if fields.marcar == "true" then
				player:set_attribute("urbos_cidade", player:get_attribute("urbos_cidade_vista"))
			else
				player:set_attribute("urbos_cidade", nil)
			end
		
		-- Caso estava so verificando regras
		elseif fields.pesquisar then
			
			-- Verificar nome dados
			local check, erro = urbos.checkname_cidade(fields.nome_cidade)
			if check == false then
				if erro == 1 then
					minetest.chat_send_player(name, "Limite de 30 letras para o nome da cidade")
				elseif erro == 2 then
					minetest.chat_send_player(name, "Nome deve conter apenas letras A-Z a-z")
				else
					minetest.chat_send_player(name, "Falha ao criar cidade. Nome invalido")
				end
				return
			end
			
			-- Verifica se ja existe cidade com esse nome
			if urbos.bd.verif("cidades", fields.nome_cidade) == false then
				minetest.chat_send_player(name, "Nenhuma cidade encontrada com esse nome")
				return
			end
			
			player:setpos(urbos.bd.pegar("cidades", fields.nome_cidade).pos)
			minetest.chat_send_player(name, "Bem vindo a "..fields.nome_cidade)
		
		end
	end
end)


-- Node
minetest.register_node("urbos:teleportador", {
	description = "Teleportador de Cidades",
	tiles = {
		"urbos_teleportador_cima.png", -- Cima
		"default_chest_top.png", -- Baixo
		"default_chest_side.png^urbos_teleportador_lado.png", -- Direita
		"default_chest_side.png^urbos_teleportador_lado.png", -- Esquerda
		"default_chest_side.png^urbos_teleportador_lado.png", -- Fundo
		"default_chest_side.png^urbos_teleportador_lado.png" -- Frente
	},
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_wood_defaults(),
	drop = "",
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Viajar para outra cidade")

		minetest.add_entity({x=pos.x, y=pos.y+0.85, z=pos.z}, "urbos:mapinha")
		local timer = minetest.get_node_timer(pos)
		timer:start(0.5)
	end,
	
	on_destruct = function(pos)
		for _, obj in pairs(minetest.get_objects_inside_radius(pos, 0.9)) do
			if obj and obj:get_luaentity() and
					obj:get_luaentity().name == "urbos:mapinha" then
				obj:remove()
				break
			end
		end
	end,
	
	on_rightclick = function(pos, node, player)
		exibir_interface_teleportador(player:get_player_name())
	end,
	
	-- Remove corda em cima caso exista
	after_destruct = function(pos, oldnode)
		
	end,
})

-- Entidade
minetest.register_entity("urbos:mapinha", {
	visual = "sprite",
	visual_size = {x=0.55, y=0.55},
	collisionbox = {0},
	physical = false,
	textures = {"urbos_mapinha.png"},
	
	on_activate = function(self)
		local pos = self.object:getpos()

		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name ~= "urbos:teleportador" then
			self.object:remove()
		end
	end
})


