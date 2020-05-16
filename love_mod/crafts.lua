
minetest.register_craft({
	output = 'love_mod:heart 7',
	recipe = {
		{"wool:red",        "","wool:red"},
		{"wool:red","wool:red","wool:red"},
		{""        ,"wool:red",""        },
	}
})

minetest.register_craft({
	output = 'love_mod:wand',
	recipe = {
		{"wool:red"      ,"default:mese_crystal","wool:red"      },
		{""              ,"default:stick"       ,""              },
		{"love_mod:heart","default:diamond"     ,"love_mod:heart"},
	}
})

minetest.register_craft({
	output = 'love_mod:sapling 8',
	recipe = {
		{"default:sapling","default:sapling","default:sapling"},
		{"default:sapling","love_mod:heart" ,"default:sapling"},
		{"default:sapling","default:sapling","default:sapling"},
	}
})

minetest.register_craft({
	output = 'love_mod:wood 4',
	recipe = {
		{'love_mod:tree'},
	}
})

minetest.register_craft({
	output = 'love_mod:wood_heart 4',
	recipe = {
		{'love_mod:tree_heart'},
	}
})

minetest.register_craft({
	output = 'love_mod:glass 8',
	recipe = {
		{"default:glass","default:glass" ,"default:glass"},
		{"default:glass","love_mod:heart","default:glass"},
		{"default:glass","default:glass" ,"default:glass"},
	}
})

minetest.register_craft({
	output = 'love_mod:heart_wall 14',
	recipe = {
		{'love_mod:heart'},
	}
})