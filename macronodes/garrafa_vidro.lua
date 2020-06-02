--[[
	Mod Macronodes para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Garrafa de Vidro
  ]]

-- Garrafa de Vidro (Vazia)
minetest.register_node("macronodes:garrafa_vidro", {
	description = "Garrafa de Vidro (Vazia)",
	drawtype = "plantlike",
	tiles = {"macronodes_garrafa.png"},
	inventory_image = "macronodes_garrafa.png",
	wield_image = "macronodes_garrafa.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})
