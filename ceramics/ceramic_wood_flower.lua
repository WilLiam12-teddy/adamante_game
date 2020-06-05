modceramics.register_ceramic("woodflower", {
	description = modceramics.translate("Ceramic Wood Flower"),
	tiles = {"tex_azulejo_madeira_florida.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:jungletree'	, 'default:clay_lump'	, 'default:jungletree'},
		{'default:clay_lump'	, 'dye:brown'			, 'default:clay_lump'},
		{'default:jungletree'	, 'default:clay_lump'	, 'default:jungletree'},
	},
	alias = {"blockwoodflower"},

	description_stair = modceramics.translate("Stair Wood Flower"),
	alias_stair = {"stairwoodflower","escadariamadeiraflorida","escadaria_madeira_florida"},
})
