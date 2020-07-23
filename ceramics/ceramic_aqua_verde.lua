modceramics.register_ceramic("aquagreen", {
	description = modceramics.translate("Ceramic Aqua Green"),
	tiles = {"tex_aqua_verde.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:gravel'		, 'default:clay_lump'	, 'default:gravel'},
		{'default:clay_lump'	, 'dye:dark_green'		, 'default:clay_lump'},
		{'default:gravel'		, 'default:clay_lump'	, 'default:gravel'},
	},
	alias = {"blockaquagreen"},

	description_stair = modceramics.translate("Stair Aqua Green"),
	alias_stair = {"stairaquagreen","escadadeaquaverde","escadaaquaverde"},
})
