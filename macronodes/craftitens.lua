--[[
	Mod Macronodes para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Craftitens
  ]]

-- Pregos
minetest.register_craftitem("macronodes:pregos", {
	description = "Pregos",
	inventory_image = "macronodes_pregos.png",
})
minetest.register_craft({
	output = 'macronodes:pregos 5',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
