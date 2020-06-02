--
-- Mod Macronodes
--
-- Punhado de Farinha de Trigo
--

-- Punhado de Farinha de Trigo
minetest.register_craftitem("macronodes:punhado_farinha", {
	description = "Punhado de Farinha de Trigo",
	inventory_image = "macronodes_punhado_farinha.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "macronodes:punhado_farinha",
	recipe = {"farming:wheat", "farming:wheat"}
})
