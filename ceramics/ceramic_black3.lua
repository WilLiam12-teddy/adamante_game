modceramics.register_ceramic("black3", {
	description = modceramics.translate("Ceramic Black (Type 3)"),
	tiles = {"tex_azulejo_preto3.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'		, 'default:coalblock'	, 'default:stone'},
		{'default:coalblock'	, 'dye:black'				, 'default:coalblock'},
		{'default:stone'		, 'default:coalblock'	, 'default:stone'},
	},
	alias = {"blockblack3"},

	description_stair = modceramics.translate("Stair Black (Type 3)"),
	alias_stair = {"stairblack3","escadariapreta3","escadaria_preta3"},
})
