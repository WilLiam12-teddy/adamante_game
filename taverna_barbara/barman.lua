--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Craftitens
	
	Script para criar, atraves da MOB-Engine CME,
	o NPC barman que atende os jogadores na taverna barbara
]]

-- Tradução de strings
local S = taverna_barbara.S

-- Encurtamento de variaveis uteis
local item_moeda = taverna_barbara.item_moeda
local desc_item_moeda = taverna_barbara.desc_item_moeda

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
		attack = {chance = 0, moving_speed = 3},
	},

	model = {
		mesh = "taverna_barbara_pessoa_comum.b3d",
		textures = {"taverna_barbara_barman.png"},
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
			idle = {name = "taverna_barbara_barman", gain = 0.7, distance = 12, time_min = 5},
		},
	},
	
	on_rightclick = function(self, clicker) -- mostra menu do barman
		minetest.show_formspec(clicker:get_player_name(), "taverna_barbara:barman", 
			"size[9,4]"
			.."label[0,0;"..S("BARMAN").."]"
			.."label[0,0.5;"..taverna_barbara.custo_cerveja.." "..taverna_barbara.item_moeda_code.."]"
			.."label[3,0.5;"..taverna_barbara.custo_whisky.." "..taverna_barbara.item_moeda_code.."]"
			.."label[6,0.5;"..taverna_barbara.custo_batanoura_defumada.." "..taverna_barbara.item_moeda_code.."]"
			.."item_image_button[0,1;3,3;taverna_barbara:cerveja;cerveja;]"
			.."item_image_button[3,1;3,3;taverna_barbara:whisky;whisky;]"
			.."item_image_button[6,1;3,3;taverna_barbara:batanoura_defumada;batanoura_defumada;]"
		)
	end,
	
	on_punch = function(self, puncher) -- impede que leve dano
		return true
	end,
	
	on_step = function(self, dtime)
	
		-- Corrige a posição para perto de chao de spawn
		if self.temp then
			self.temp = self.temp + dtime
		else
			self.temp = 0
		end
		if self.temp >= 15 then
			self.temp = 0

			-- Remove se tem mais de 1 por perto
			if table.maxn(creatures.find_target(self.object:getpos(), 10, {
				search_type = "mate",
				mob_name = "taverna_barbara:barman",
				xray = true,
				no_count = false
			})) > 1 then
		                self.object:remove()
		        end
		        
		end
		
	end,


}

creatures.register_mob("taverna_barbara:barman", def)

-- receptor dos botoes do menu do barman
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "taverna_barbara:barman" then
		if fields.cerveja then
			
			local custo = taverna_barbara.custo_cerveja
			
			if taverna_barbara.tror.trocar_plus(player, {taverna_barbara.item_moeda.." "..custo}, {"taverna_barbara:cerveja 1"}) == false then
				local desc_item = minetest.registered_items["taverna_barbara:cerveja"].description
				local desc_moeda = taverna_barbara.desc_item_moeda
				minetest.chat_send_player(
					player:get_player_name(), 
					S("Voce precisa de @1 @2 para comprar @3", tostring(custo), desc_moeda, desc_item))
				return
			end
			
		elseif fields.whisky then
			
			local custo = taverna_barbara.custo_whisky
			
			if taverna_barbara.tror.trocar_plus(player, {item_moeda.." "..custo}, {"taverna_barbara:whisky 1"}) == false then
				local desc_item = minetest.registered_items["taverna_barbara:whisky"].description
				minetest.chat_send_player(
					player:get_player_name(), 
					S("Voce precisa de @1 @2 para comprar @3", tostring(custo), desc_item_moeda, desc_item))
				return
			end
			
		elseif fields.batanoura_defumada then
			
			local custo = taverna_barbara.custo_batanoura_defumada
			
			if taverna_barbara.tror.trocar_plus(player, {item_moeda.." "..custo}, {"taverna_barbara:batanoura_defumada 1"}) == false then
				local desc_item = minetest.registered_items["taverna_barbara:batanoura_defumada"].description
				minetest.chat_send_player(
					player:get_player_name(), 
					S("Voce precisa de @1 @2 para comprar @3", tostring(custo), desc_item_moeda, desc_item))
				return
			end
			
		end
	end
end)


-- Node Piso do barman
minetest.register_node("taverna_barbara:piso_barman", {
	description = S("Piso de Barman"),
	tiles = {
		"default_pine_wood.png^taverna_barbara_piso_barman.png",
	},
	is_ground_content = false,
	groups = {choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
})

local verificar_barman = function(pos)
	if table.maxn(creatures.find_target(pos, 10, {
		search_type = "mate",
		mob_name = "taverna_barbara:barman",
		xray = true,
		no_count = false
	})) == 0 then
		minetest.add_entity({x=pos.x,y=pos.y+2.5,z=pos.z}, "taverna_barbara:barman")
	end
end

-- Coloca e verifica o barman
minetest.register_abm({
	nodenames = {"taverna_barbara:piso_barman"},
	interval = 60,
	chance = 1,
	action = function(pos)		
		-- Espera um tempo para que o mapa seja corretamente carregado
		minetest.after(5, verificar_barman, pos)
	end,
})

