--[[
	Mod Macronodes para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Enxofre
  ]]

-- Enxofre
minetest.register_craftitem("macronodes:enxofre", { 
	description = "Enxofre",
	stack_max = 70,
	inventory_image = "macronodes_enxofre.png",
	wield_image = "macronodes_enxofre_na_mao.png",
})

-- Receita de Enxofre
minetest.register_craft({ 
	output = "macronodes:enxofre",
	recipe = {
		{"default:coal_lump", "default:gravel", "default:coal_lump"},
		{"default:coal_lump", "bucket:bucket_lava", "default:coal_lump"},
		{"default:paper", "default:paper", "default:paper"}
	}
})
