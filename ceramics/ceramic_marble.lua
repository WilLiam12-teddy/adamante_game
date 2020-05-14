modceramics.register_ceramic("marble", {
	description = modceramics.translate("Ceramic Marble"),
	tiles = {"tex_marmore.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'		, 'default:clay_lump'	, 'default:stone'},
		{'default:clay_lump'		, 'dye:white'		, 'default:clay_lump'},
		{'default:stone'		, 'default:clay_lump'	, 'default:stone'},
	},
	alias = {"blockmarble"},

	description_stair = modceramics.translate("Stair Marble"),
	alias_stair = {"stairmarble","escadademarmore","escadamarmore"},
})
