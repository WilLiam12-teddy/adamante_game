modceramics.register_ceramic("black2", {
	description = modceramics.translate("Ceramic Black (Type 2)"),
	tiles = {"tex_azulejo_preto2.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'		, 'dye:black'					, 'default:stone'},
		{'dye:black'			, 'default:obsidian_glass'	, 'dye:black'},
		{'default:stone'		, 'dye:black'					, 'default:stone'},
	},
	alias = {"blockblack2"},

	description_stair = modceramics.translate("Stair Black (Type 2)"),
	alias_stair = {"stairblack2","escadariapreta2","escadaria_preta2"},
})
