--[[
	Mod Macronodes para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Nodes decorativos
  ]]

-- Mesa
minetest.register_node("macronodes:mesa", {
	description = "Mesa",
	drawtype = "nodebox",
	paramtype = 'light',
	tiles = {
			"macronodes_mesa_cima.png", -- Cima
			"macronodes_mesa_cima.png", -- Baixo
			"macronodes_mesa_lado.png", -- Lado direito
			"macronodes_mesa_lado.png", -- Lado esquerda
			"macronodes_mesa_lado.png", -- Fundo
			"macronodes_mesa_lado.png"}, -- Frente
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- Tampa
				{0.1875, -0.5, -0.4375, 0.4375, 0.4375, -0.1875}, -- Perna_1
				{-0.4375, -0.5, -0.4375, -0.1875, 0.375, -0.1875}, -- Perna_2
				{-0.4375, -0.5, 0.1875, -0.1875, 0.375, 0.4375}, -- Perna_3
				{0.1875, -0.5, 0.1875, 0.4375, 0.375, 0.4375}, -- Perna_4
		}
	},
	groups = {choppy=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})
--[[ -- Receita cancelada devido o mod oficios
minetest.register_craft({
	output = 'macronodes:mesa',
	recipe = {
		{'default:tree', 'macronodes:pregos', 'default:tree'},
		{'default:steel_ingot', 'default:wood', 'default:steel_ingot'},
		{'default:tree', 'default:steel_ingot', 'default:tree'},
	}
})
]]

-- Vaso de Flores
minetest.register_node("macronodes:vaso_de_flores", {
	description = "Vaso de Flores",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	tiles = {
			"macronodes_vasodeflores_cima.png", -- Cima
			"macronodes_vasodeflores_baixo.png", -- Baixo
			"macronodes_vasodeflores_direita.png", -- Lado direito
			"macronodes_vasodeflores_esquerda.png", -- Lado esquerdo
			"macronodes_vasodeflores_fundo.png", -- Fundo
			"macronodes_vasodeflores_frente.png"}, -- Frente
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}, -- Vaso_(baixo)
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.1875, 0.3125}, -- Vaso_(cima)
			{0, -0.375, 0, 0.005, 0.125, 0.0505}, -- Caule_1
			{-0.1875, 0, -0.005, 0.1875, 0.1875, 0}, -- Flor_1a
			{-0.125, -0.0625, -0.005, 0.125, 0.25, 0}, -- Flor_1b
			{0.0625, -0.5, 0, 0.125, 0.375, 0.0155}, -- Caule_2
			{0.125, 0.25, -0.1875, 0.13, 0.4375, 0.1875}, -- Flor_2a
			{0.125, 0.1875, -0.125, 0.135, 0.5, 0.125}, -- Flor_2b
		}
	},
	groups = {choppy=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'macronodes:vaso_de_flores',
	recipe = {
		{'flowers:dandelion_yellow', '', 'flowers:geranium'},
		{'default:clay_brick', 'default:dirt', 'default:clay_brick'},
		{'dye:orange', 'default:clay_brick', 'dye:orange'},
	}
})

-- Pedra Lapidada (Tipo 01)
minetest.register_node("macronodes:pedralapidada_tipo01", {
	description = "Pedra Lapidada (Tipo 01)",
	tiles = {"macronodes_pedralapidada_tipo01.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'macronodes:pedralapidada_tipo01',
	recipe = {
		{'default:stone'},
	}
})

-- Pedra Lapidada (Tipo 02)
minetest.register_node("macronodes:pedralapidada_tipo02", {
	description = "Pedra Lapidada (Tipo 02)",
	tiles = {"macronodes_pedralapidada_tipo02.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'macronodes:pedralapidada_tipo02',
	recipe = {
		{'macronodes:pedralapidada_tipo01', 'macronodes:pedralapidada_tipo01'},
		{'macronodes:pedralapidada_tipo01', 'macronodes:pedralapidada_tipo01'},
	}
})

-- Madeira de Carvalho Entalhada
minetest.register_node("macronodes:madeiraentalhada", {
	description = "Madeira Entalhada",
	tiles = {"macronodes_madeiraentalhada.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=1},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_craft({
	output = 'macronodes:pedralapidada_tipo02',
	recipe = {
		{'macronodes:pregos', 'macronodes:complexoquimico_contrafogo', 'macronodes:pregos'},
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:paper', 'default:paper', 'default:paper'},
	}
})

-- Tijolinhos Brancos
minetest.register_node("macronodes:tijolinhos_brancos", {
	description = "Tijolinhos Brancos",
	tiles = {"macronodes_tijolinhos_brancos.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'macronodes:tijolinhos_brancos',
	recipe = {
		{'default:paper', 'dye:white', 'default:paper'},
		{'default:paper', 'default:brick', 'default:paper'},
		{'default:paper', 'default:paper', 'default:paper'},
	}
})

-- Pedra Egipcia
--[[
minetest.register_node("macronodes:pedra_egipcia", {
	description = "Pedra Egipcia",
	tiles = {"macronodes_pedraegipcia.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
]]

-- Carvalho Entalhado Nordico
--[[
minetest.register_node("macronodes:carvalho_entalhado_nordico", {
	description = "Carvalho Entalhado Nordico",
	tiles = {"default_tree_top.png", "default_tree_top.png", "macronodes_carvalho_entalhado_nordico.png"},
	is_ground_content = false,
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})
]]

minetest.register_node("macronodes:luminaria", {
	description = "Luminaria Simples",
	tiles = {"macronodes_luminaria.png"},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15,
	is_ground_content = false,
	groups = {choppy=2,dig_immediate=1,flammable=1,oddly_breakable_by_hand=2},
	sounds = default.node_sound_stone_defaults(),
})
--[[
minetest.register_node("macronodes:luminaria", {
	description = "Luminaria Simples",
	tiles = "macronodes_luminaria.png",
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 5,
	groups = {choppy=2,dig_immediate=1,flammable=1},
	sounds = default.node_sound_defaults(),
})
]]--
if minetest.get_modpath("currency") then
	minetest.register_craft({
		output = 'macronodes:luminaria',
		recipe = {
			{'group:stick', 'currency:cartolina', 'group:stick'},
			{'currency:cartolina', 'default:torch', 'currency:cartolina'},
			{'group:stick', 'currency:cartolina', 'group:stick'},
		}
	})
else
	minetest.register_craft({
		output = 'macronodes:luminaria',
		recipe = {
			{'group:stick', 'default:paper', 'group:stick'},
			{'default:paper', 'default:torch', 'default:paper'},
			{'group:stick', 'default:paper', 'group:stick'},
		}
	})
end
