--
-- Mod Macronodes
--
-- Rosquinha de Trigo
--

-- Rosquinha de Trigo
minetest.register_craftitem("macronodes:rosquinha", {
	description = "Rosquinha de Trigo",
	inventory_image = "macronodes_rosquinha.png",
	on_use = minetest.item_eat(1),
	stack_max = 20,
})
minetest.register_craft({
	type = "cooking",
	cooktime = 8,
	output = "macronodes:rosquinha",
	recipe = "macronodes:punhado_farinha"
})
