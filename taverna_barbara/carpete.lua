--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Carpete
	
  ]]

-- Tradução de strings
local S = taverna_barbara.S

-- Carpete de palha
minetest.register_node("taverna_barbara:carpete", {
	description = S("Carpete de Taverna Bárbara"),
	tiles = {"wool_red.png"},
	drawtype = "nodebox",
	paramtype = "light",
	liquids_pointable = false,
	walkable = false,
	buildable_to = true,
	drop = {},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
    	groups = {choppy=2,oddly_breakable_by_hand=3,flammable=1,attached_node=1,fall_damage_add_percent=-5},
    	sounds = default.node_sound_leaves_defaults(),
})
