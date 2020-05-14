modceramics.register_ceramic("orange", {
	description = modceramics.translate("Ceramic Orange"),
	tiles = {"tex_azulejo_laranja.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'		, 'dye:orange'	, 'default:stone'},
		{'dye:orange'			, 'dye:white'	, 'dye:orange'},
		{'default:stone'		, 'dye:orange'	, 'default:stone'},
	},
	alias = {"blockorange"},

	description_stair = modceramics.translate("Stair Orange"),
	alias_stair = {"stairorange","escadarialaranja","escadaria_laranja"},
})
