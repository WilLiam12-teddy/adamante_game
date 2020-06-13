--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Trambiqueiro
	
	Script para criar, atraves da MOB-Engine CME,
	o NPC barman que atende os jogadores na taverna barbara
	
	Dados da textura do trambiqueiro
	Nome: Semmett9
	Autor: Infinatum 
	Licença: CC BY-NC-SA 3.0
	Fonte: http://minetest.fensta.bplaced.net/
	Data: 8/Jul/2016
]]

-- Tradução de strings
local S = taverna_barbara.S

-- Atalho para diretrizes
local diretrizes = taverna_barbara.trambiqueiro

-- Formspec de dispensa do trambiqueiro
local formspec_dispensa = "size[7,3]"
	.."image[0.2,0.3;3,3;taverna_barbara_trambiqueiro_face.png]"
	.."label[3,0.5;TRAMBIQUEIRO \n\nVolte outra hora que eu \nconsigo algo para \nlhe oferecer]"


-- Controle de qual trambiqueiro o jogador acessou
local acesso = {}

-- Retira o acesso do jogador que sair do servidor
minetest.register_on_leaveplayer(function(player)
	if player then
		local name_removido = player:get_player_name()
		local novo_acesso = {}
		for name, dados in pairs(acesso) do
			if name ~= name_removido then
				novo_acesso[name] = acesso[name_removido]
			end
		end
		acesso = novo_acesso
	end
end)

-- Restaura a disponibilidade da entidade
local restaurar_trambique = function(self)
	if self and self.disp ~= nil then
		self.disp = true
	end
end

-- Sortear trambique
local sortear_trambique = function()
	local trambique = diretrizes.ofertas[math.random (1, table.maxn(diretrizes.ofertas))]
	return {
		custo = string.split(trambique.custo, " "),
		item = string.split(trambique.item, " ")
	}
end

-- receptor dos botoes do menu do trambiqueiro
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "taverna_barbara:trambiqueiro" and fields.aceitar then
		local sender_name = player:get_player_name()
		if acesso[sender_name] then
		
			local self = acesso[sender_name]
			if self.disp then
				
				local item_custo = self.trambique.custo[1]
				local custo = self.trambique.custo[2]
				local item_oferta = self.trambique.item[1]
				local oferta = self.trambique.item[2]
			
				if taverna_barbara.tror.trocar_plus(player, {item_custo.." "..custo}, {item_oferta.." "..oferta}) == false then
					local desc_item = minetest.registered_items[item_oferta].description
					local desc_item_custo = minetest.registered_items[item_custo].description
					minetest.chat_send_player(
						player:get_player_name(), 
						"Voce precisa de "..tostring(custo).." "..desc_item_custo.." para comprar "..desc_item)
					return
				end
				
				minetest.show_formspec(sender_name, "taverna_barbara:trambiqueiro", formspec_dispensa)
				self.disp = false
				self.trambique = sortear_trambique()
				minetest.after(diretrizes.tempo_restauro_trambique, restaurar_trambique, self)
			end
		end
	end
end)

-- Trambiqueiro
local def = {
	
	-- Geral
	stats = {
		hp = 18,
		lifetime = 1800, -- 30 Minutos
		can_jump = 0,
		can_swim = false,
		can_burn = false,
		has_falldamage = true,
		has_kockback = false,
		hostile = false,
	},

	modes = {
		idle = {chance = 0.7, duration = 3, update_yaw = 6},
		walk = {chance = 0.3, duration = 5.5, moving_speed = 1.5},
		-- special modes
	},

	model = {
		mesh = "taverna_barbara_pessoa_comum.b3d",
		textures = {"taverna_barbara_trambiqueiro.png"},
		collisionbox_width = 0.7,
		collisionbox_height = 1.8,
		center_height = -1,
		rotation = 0.0,
		vision_height = 0,
		animations = {
			idle = {start = 0, stop = 80, speed = 15},
			walk = {start = 168, stop = 188, speed = 15.5},
			attack = {start = 200, stop = 220, speed = 25},
			death = {start = 81, stop = 162, speed = 45, loop = false, duration = 8},
		},
	},

	sounds = {
		swim = {name = "creatures_splash", gain = 1.0, distance = 10},
		random = {
			idle = {name = "taverna_barbara_trambiqueiro", gain = 0.7, distance = 12, time_min = 5},
		},
	},

	spawning = {

		abm_nodes = {
			spawn_on = {},
		},

		abm_interval = 6, -- 5 Minutos
		abm_chance = 1,
		max_number = 0, -- devido uma falha se definir para 1 aparece 2
		number = 1,
		light = {min = 0, max = 15},
		height_limit = {min = 0, max = 150},
	},
	
	on_step = function(self, dtime)
	
		-- Corrige a posição para perto de seu bau
		if self.temp then
			self.temp = self.temp + dtime
		else
			self.temp = 0
		end
		if self.temp >= 15 then
			self.temp = 0
			
			-- Verifica se esta bem perto do bau
			local me = self.object
			if minetest.find_node_near(me:getpos(), 5, {"taverna_barbara:bau_trambiqueiro"}) == nil then
				-- teleporta para o bau ou remove(exclui)
				local pos = minetest.find_node_near(me:getpos(), 15, {"taverna_barbara:bau_trambiqueiro"})
				if pos then
					local node = minetest.get_node(pos)
					local p = minetest.facedir_to_dir(node.param2)
					me:moveto({x=pos.x-p.x,y=pos.y+1.5,z=pos.z-p.z})
				else
					me:remove()
				end
			end
			
			-- Remove se tem mais de 1 por perto
			if table.maxn(creatures.find_target(self.object:getpos(), 10, {
				search_type = "mate",
				mob_name = "taverna_barbara:trambiqueiro",
				xray = true,
				no_count = false
			})) > 1 then
		                self.object:remove()
		        end
		end
		
	end,
	
	
	on_rightclick = function(self, clicker)
	
		-- Cria um novo trambique caso ainda não tenha
		if self.trambique == nil then
			self.trambique = sortear_trambique()
			self.disp = true
		end
		
		if self.disp then -- Verifica a disponibilidade para trambique
			acesso[clicker:get_player_name()] = self
			minetest.show_formspec(clicker:get_player_name(), "taverna_barbara:trambiqueiro", 
				"size[9,4]"
				.."label[0,0;TRAMBIQUEIRO]"
				.."item_image_button[0,1;3,3;"..self.trambique.custo[1].." "..self.trambique.custo[2]..";;]" -- Item que paga
				.."image_button[3,1;3,3;taverna_barbara_aceitar_trambique.png;aceitar;Aceitar]" -- Botao imagem de realizar troca
				.."item_image_button[6,1;3,3;"..self.trambique.item[1].." "..self.trambique.item[2]..";;]" -- Item que recebe
			)
		else
			minetest.show_formspec(clicker:get_player_name(), "taverna_barbara:trambiqueiro", formspec_dispensa)
		end
	end,
	
	
	on_punch = function(self, puncher) -- impede que leve dano
		return true
	end,

}

creatures.register_mob("taverna_barbara:trambiqueiro", def)

-- Node Bau do Trambiqueiro
minetest.register_node("taverna_barbara:bau_trambiqueiro", {
	description = "Bau o Trambiqueiro",
	tiles = {
		"default_chest_top.png", 
		"default_chest_top.png", 
		"default_chest_side.png^taverna_barbara_bau_trambiqueiro.png",
		"default_chest_side.png^taverna_barbara_bau_trambiqueiro.png", 
		"default_chest_side.png", 
		"default_chest_front.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	legacy_facedir_simple = true,
	groups = {choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Bau do Trambiqueiro") -- infotext pode ser serializado
	end,
})

local verificar_trambiqueiro = function(pos)
	if table.maxn(creatures.find_target(pos, 10, {
		search_type = "mate",
		mob_name = "taverna_barbara:trambiqueiro",
		xray = true,
		no_count = false
	})) == 0 then
		local node = minetest.get_node(pos)
		local p = minetest.facedir_to_dir(node.param2)
		minetest.add_entity({x=pos.x-p.x,y=pos.y+1.5,z=pos.z-p.z}, "taverna_barbara:trambiqueiro")
	end
end

-- Coloca e verifica o barman
minetest.register_abm({
	nodenames = {"taverna_barbara:bau_trambiqueiro"},
	interval = 60,
	chance = 1,
	action = function(pos)		
		-- Espera alguns segundos para que o mapa seja corretamente carregado
		minetest.after(5, verificar_trambiqueiro, pos)
	end,
})
