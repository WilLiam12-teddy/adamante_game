--
-- Receitas 
--

minetest.register_craft({
	output = 'brazutec:cub_fechado',
	recipe = {
		{'', '', 'default:steel_ingot'},
		{'', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'brazutec:bateria'},
	}
})
minetest.register_craft({
	output = 'brazutec:cub_fechado',
	recipe = {
		{'default:steel_ingot', '', ''},
		{'default:steel_ingot', '', ''},
		{'brazutec:bateria', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
minetest.register_craft({
	output = 'brazutec:bateria',
	recipe = {
		{'default:paper', 'default:copper_ingot', 'default:paper'},
		{'default:paper', 'default:coal_lump', 'default:paper'},
		{'default:paper', 'default:steel_ingot', 'default:paper'},
	}
})