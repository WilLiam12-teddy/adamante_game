modceramics.register_ceramic("black1", {
	description = modceramics.translate("Ceramic Black (Type 1)"),
	tiles = {"tex_azulejo_preto1.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'		, 'wool:black'					, 'default:stone'},
		{'wool:black'			, 'default:obsidian_glass'	, 'wool:black'},
		{'default:stone'		, 'wool:black'					, 'default:stone'},
	},
	alias = {"blockblack1"},

	description_stair = modceramics.translate("Stair Black (Type 1)"),
	alias_stair = {"stairblack1","escadariapreta1","escadaria_preta1"},
})
