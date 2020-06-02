--[[
	Mod Macronodes para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Cartolina
  ]]

-- Cartolina
minetest.register_craftitem("macronodes:cartolina", {
    description = "Cartolina",
    inventory_image = "macronodes_cartolina.png",
})

-- Cartolinha
minetest.register_craft({
	output = 'macronodes:cartolina',
	recipe = {
		{'default:paper', 'default:paper', 'default:paper'},
		{'default:paper', 'default:cobble', 'default:paper'},
		{'default:paper', 'default:paper', 'default:paper'},
	}
})

-- Rolo de Cartolinha
minetest.register_craftitem("macronodes:rolo_cartolina", {
    description = "Rolo de Cartolina",
    inventory_image = "macronodes_rolo_cartolina.png",
})

-- Rolo de Cartolinha
minetest.register_craft({
	output = 'macronodes:rolo_cartolina',
	recipe = {
		{'macronodes:cartolina', 'macronodes:cartolina', 'macronodes:cartolina'},
		{'macronodes:cartolina', 'group:stick', 'macronodes:cartolina'},
		{'macronodes:cartolina', 'macronodes:cartolina', 'macronodes:cartolina'},
	}
})
