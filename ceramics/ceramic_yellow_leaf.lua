modceramics.register_ceramic("yellowleaf", {
	description = modceramics.translate("Ceramic Yellow Leaf"),
	tiles = {"tex_azulejo_folha_amarela.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'	, 'default:jungleleaves'		, 'default:stone'},
		{'default:jungleleaves'	, 'default:gold_lump'	, 'default:jungleleaves'},
		{'default:stone'	, 'default:jungleleaves'		, 'default:stone'},
	},
	alias = {"blockyellowleaf"},

	description_stair = modceramics.translate("Stair Yellow Leaf"),
	alias_stair = {"stairyellowleaf","escadariafolhaamarela","escadaria_folha_amarela"},
})
