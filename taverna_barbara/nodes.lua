--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Nodes
	
  ]]

-- Tradução de strings
local S = taverna_barbara.S

-- Encurtamento de variaveis uteis
local item_moeda = taverna_barbara.item_moeda
local desc_item_moeda = taverna_barbara.desc_item_moeda

-- Placa da taverna barbara
minetest.register_node("taverna_barbara:placa", {
	description = S("Placa de Taverna Bárbara"),
	drawtype = "nodebox",
	tiles = {
		"taverna_barbara_placa_lado.png", -- Cima
		"taverna_barbara_placa_lado.png", -- Baixo
		"taverna_barbara_placa_lado.png", -- Lado direito
		"taverna_barbara_placa_lado.png", -- Lado esquerda
		"taverna_barbara_placa_lado.png", -- Fundo
		"default_pine_wood.png^taverna_barbara_placa.png" -- Frente
	},
	inventory_image = "taverna_barbara_placa.png",
	wield_image = "taverna_barbara_placa.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.4375, 0.5, 0.375, 0.5},
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.125, 0.4375, 0.5, 0.25, 0.5}, -- NodeBox1
			{-0.4375, -0.3125, 0.4375, 0.4375, -0.0625, 0.5}, -- NodeBox2
			{-0.375, -0.375, 0.4375, 0.375, -0.25, 0.5}, -- NodeBox3
			{-0.3125, -0.4375, 0.4375, 0.3125, -0.1875, 0.5}, -- NodeBox4
			{-0.25, -0.5, 0.4375, 0.25, -0.3125, 0.5}, -- NodeBox5
			{-0.375, 0, 0.4375, 0.375, 0.3125, 0.5}, -- NodeBox6
			{-0.25, 0.0625, 0.4375, 0.25, 0.375, 0.5}, -- NodeBox7
		}
	},
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("taverna_barbara:expositor_amendoim", {
	description = S("Expositor de Amendoim Crocante"),
	tiles = {
		"default_pine_wood.png^taverna_barbara_expositor_amendoim_cima.png", -- Cima
		"default_pine_wood.png", -- Baixo
		"default_pine_wood.png^taverna_barbara_expositor_amendoim_direita.png", -- Lado direito
		"default_pine_wood.png^taverna_barbara_expositor_amendoim_esquerda.png", -- Lado esquerda
		"default_pine_wood.png^taverna_barbara_expositor_amendoim_fundo.png", -- Fundo
		"default_pine_wood.png^taverna_barbara_expositor_amendoim_frente.png" -- Frente
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- Base_1
			{-0.375, -0.4375, 0.125, -0.1875, -0.125, 0.3125}, -- Caixa_1
			{-0.375, -0.4375, -0.375, -0.1875, -0.125, -0.1875}, -- Caixa_2
			{-0.375, -0.4375, -0.125, -0.1875, -0.125, 0.0625}, -- Caixa_3
			{-0.125, -0.4375, -0.375, 0.0625, -0.125, -0.1875}, -- Caixa_4
			{-0.125, -0.4375, -0.125, 0.0625, -0.125, 0.0625}, -- Caixa_5
			{-0.125, -0.4375, 0.125, 0.0625, -0.125, 0.3125}, -- Caixa_6
			{0.125, -0.4375, -0.375, 0.3125, -0.125, -0.1875}, -- Caixa_7
			{0.125, -0.4375, -0.125, 0.3125, -0.125, 0.0625}, -- Caixa_8
			{0.125, -0.4375, 0.125, 0.3125, -0.125, 0.3125}, -- Caixa_9
			{0.375, -0.5, 0.375, 0.4375, 0.25, 0.4375}, -- Mastro
			{-0.3125, -0.0625, 0.375, 0.375, 0.25, 0.4375}, -- Bandeira
		}
	},
	groups = {attached_node=1,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Amendoim Crocante")) -- infotext pode ser serializado
	end,
	on_rightclick = function(pos, node, player)
		minetest.show_formspec(player:get_player_name(), "taverna_barbara:expositor_amendoim", 
			"size[3,3]"
			.."item_image_button[0,0;3,3;taverna_barbara:amendoim;comprar;]"
		)
	end,
})

		
-- Expositor de Balinhas
minetest.register_node("taverna_barbara:expositor_balinhas", {
	description = S("Expositor de Balinhas"),
	tiles = {
		"default_pine_wood.png^taverna_barbara_expositor_balinhas_cima.png", -- Cima
		"default_pine_wood.png^taverna_barbara_expositor_balinhas_baixo.png", -- Baixo
		"default_pine_wood.png^taverna_barbara_expositor_balinhas_direita.png", -- Lado direito
		"default_pine_wood.png^taverna_barbara_expositor_balinhas_esquerda.png", -- Lado esquerda
		"default_pine_wood.png^taverna_barbara_expositor_balinhas_fundo.png", -- Fundo
		"default_pine_wood.png^taverna_barbara_expositor_balinhas_frente.png" -- Frente
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.0625, 0.4375, -0.4375, 0.0625}, -- Base_1
			{-0.25, -0.4375, -0.25, 0.25, 0, 0.25}, -- Torre
			{-0.3125, 0.0625, -0.0625, 0.3125, 0.3125, 0.0625}, -- Placa
			{-0.0625, 0, -0.0625, 0.0625, 0.0625, 0.0625}, -- Mastro
			{-0.3125, -0.125, 0.0625, 0.3125, -0.0625, 0.1875}, -- Bala_1
			{-0.3125, -0.125, -0.1875, 0.3125, -0.0625, -0.0625}, -- Bala_2
			{-0.3125, -0.25, 0.0625, 0.3125, -0.1875, 0.1875}, -- Bala_3
			{-0.3125, -0.25, -0.1875, 0.3125, -0.1875, -0.0625}, -- Bala_4
			{-0.0625, -0.5, -0.4375, 0.0625, -0.4375, 0.4375}, -- Base_2
			{-0.3125, -0.375, -0.1875, 0.3125, -0.3125, -0.0625}, -- Bala_5
			{-0.3125, -0.375, 0.0625, 0.3125, -0.3125, 0.1875}, -- Bala_6
			{0.0625, -0.375, -0.3125, 0.1875, -0.3125, 0.3125}, -- Bala_7
			{-0.1875, -0.375, -0.3125, -0.0625, -0.3125, 0.3125}, -- Bala_8
			{-0.1875, -0.25, -0.3125, -0.0625, -0.1875, 0.3125}, -- Bala_9
			{0.0625, -0.25, -0.3125, 0.1875, -0.1875, 0.3125}, -- Bala_10
			{-0.1875, -0.125, -0.3125, -0.0625, -0.0625, 0.3125}, -- Bala_11
			{0.0625, -0.125, -0.3125, 0.1875, -0.0625, 0.3125}, -- Bala_12
		}
	},
	groups = {attached_node=1,choppy=2},
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Balinhas Sortidas")) -- infotext pode ser serializado
	end,
	on_rightclick = function(pos, node, player)
		minetest.show_formspec(player:get_player_name(), "taverna_barbara:expositor_balinhas", 
			"size[3,3]"
			.."item_image_button[0,0;3,3;taverna_barbara:balinha_sortida;comprar;]"
		)
	end,
})

-- receptor dos botoes dos expositores
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "taverna_barbara:expositor_balinhas" then
		if fields.comprar then
			
			local custo = taverna_barbara.custo_balinha_sortida
			
			if taverna_barbara.tror.trocar_plus(player, {item_moeda.." "..custo}, {"taverna_barbara:balinha_sortida 1"}) == false then
				local desc_item = minetest.registered_items["taverna_barbara:balinha_sortida"].description
				minetest.chat_send_player(
					player:get_player_name(), 
					S("Voce precisa de @1 @2 para comprar @3", tostring(custo), desc_item_moeda, desc_item))
				return
			end
		end
	elseif formname == "taverna_barbara:expositor_amendoim" then
		if fields.comprar then
			
			local custo = taverna_barbara.custo_amendoim
			
			if taverna_barbara.tror.trocar_plus(player, {item_moeda.." "..custo}, {"taverna_barbara:amendoim 1"}) == false then
				local desc_item = minetest.registered_items["taverna_barbara:amendoim"].description
				minetest.chat_send_player(
					player:get_player_name(), 
					S("Voce precisa de @1 @2 para comprar @3", tostring(custo), desc_item_moeda, desc_item))
				return
			end
		end
	end
end)

-- Node Garrafa de Cerveja (decorativo)
minetest.register_node("taverna_barbara:node_cerveja", {
	description = S("Garrafa de Cerveja"),
	tiles = {
		"taverna_barbara_garrafa_cerveja_cima.png", -- cima
		"taverna_barbara_garrafa_cerveja_baixo.png", -- baixo
		"taverna_barbara_garrafa_cerveja_lado2.png", -- direita
		"taverna_barbara_garrafa_cerveja_lado2.png", -- esquerda
		"taverna_barbara_garrafa_cerveja_lado1.png", -- fundo
		"taverna_barbara_garrafa_cerveja_lado1.png" -- frente
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125}, -- Centro
			{-0.1875, -0.4375, -0.0625, 0.1875, 0, 0.0625}, -- Face_1
			{-0.0625, -0.4375, -0.1875, 0.0625, 0, 0.1875}, -- Face_2
			{-0.0625, -0.5, -0.0625, 0.0625, 0.375, 0.0625}, -- tubo_fino
		}
	},
	drop = "taverna_barbara:cerveja",
	groups = {attached_node=1,choppy=2,dig_immediate=3,not_in_creative_inventory=1},
	sounds = default.node_sound_defaults(),
})

-- Node Garrafa de Whisky (decorativo)
minetest.register_node("taverna_barbara:node_whisky", {
	description = S("Garrafa de Whisky"),
	tiles = {
		"taverna_barbara_garrafa_whisky_cima.png", -- cima
		"taverna_barbara_garrafa_whisky_baixo.png", -- baixo
		"taverna_barbara_garrafa_whisky_lado2.png", -- direita
		"taverna_barbara_garrafa_whisky_lado2.png", -- esquerda
		"taverna_barbara_garrafa_whisky_lado1.png", -- fundo
		"taverna_barbara_garrafa_whisky_lado1.png" -- frente
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0, 0.1875}, -- Corpo
			{-0.125, -0.25, -0.125, 0.125, 0.0625, 0.125}, -- Face_superior
			{-0.0625, -0.0625, -0.0625, 0.0625, 0.375, 0.0625}, -- tubo_fino
		}
	},
	drop = "taverna_barbara:whisky",
	groups = {attached_node=1,choppy=2,dig_immediate=3,not_in_creative_inventory=1},
	sounds = default.node_sound_defaults(),
})

-- Fundamento da taverna
minetest.register_node("taverna_barbara:fundamento", {
	description = S("Fundamento da Taverna"),
	tiles = {"default_cobble.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 1,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	drop = {},
	
	-- Nao pode ser escavado/quebrado por jogadores
	on_dig = function() end,
	
	-- Impede explosão
	on_blast = function() end,
})

