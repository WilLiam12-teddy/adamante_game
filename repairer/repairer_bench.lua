repairer.nodes.bench = {
	type = "fixed",
	fixed = {
		{-0.5,0.4375,-0.5,	0.5,0.5,0.5}, --Tabua principal
		{-0.5,0.6875,0.5,	0.5,0.5,0.4375}, --Tabua de Tomadas
		{-0.4375,0.1875,-0.4375,	0.4375,0.4375,0.4375}, --Gaveta

		{-0.0625,0.3437,-0.4375,	0.0625,0.2812,-0.5}, --Puchador


		{-0.375,0.4375,-0.375,	-0.25,-0.5,-0.25}, --Perna
		{-0.375,0.4375,0.375,	-0.25,-0.5,0.25}, --Perna
		{0.375,0.4375,-0.375,	0.25,-0.5,-0.25}, --Perna
		{0.375,0.4375,0.375,		0.25,-0.5,0.25}, --Perna
	}
}

minetest.register_node("repairer:bench", {
	description = 
		core.colorize("#00ff00", repairer.translate("Repairer Bench"))
		.."\n\t * "..repairer.translate("to repair faulty items mods."),
	--inventory_image = "homedecor_trophy_inv.png",
	drawtype = "nodebox",
	paramtype = "light", --Nao sei pq, mas o blco nao aceita a luz se nao tiver esta propriedade
	paramtype2 = "facedir",
	--walkable = false,
	node_box = repairer.nodes.bench,
	selection_box = repairer.nodes.bench,
	--tiles = {"default_steel_block.png^text_shieldblock.png"},
	--tiles = {"text_trophy.png^text_trophy_simbol.png"},
	tiles = {
		"top_64x64_wood.png^[transformR180^top_64x64_tools.png", --cima 
		"top_64x64_wood.png^[colorize:black:192", --baixo
		"top_64x64_wood.png^[colorize:black:128", --esquerda
		"top_64x64_wood.png^[colorize:black:128",  --direita
		"top_64x64_wood.png^[colorize:black:128", --traz
		"top_64x64_wood.png^[colorize:black:128^front_64x64_drawer_and_jacks.png" --frente
	},
	--is_ground_content = true,
	groups = {snappy=3, dig_immediate=2, attached_node=1},
	--sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos);
		meta:set_string("infotext",  
			core.colorize("#00ff00", repairer.translate("Repairer Bench"))
			.."\n\t * "..repairer.translate("to repair faulty items mods.")
		)		
	end,
})

minetest.register_craft({
	output = "repairer:bench",
	recipe = {
		{ "default:sword_bronze"	,"default:book"	,"screwdriver:screwdriver" },
		{ "group:wood"					,"group:wood"		,"group:wood" },
		{ "default:stick"				,""					,"default:stick" }
	},
})
