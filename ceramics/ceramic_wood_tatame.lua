modceramics.register_ceramic("woodtatame", {
	description = modceramics.translate("Ceramic Wood Tatame"),
	tiles = {"tex_madeira_tatame.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	--sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:tree'	, 'wool:brown'				, 'default:tree'},
		{'wool:brown'		, 'default:junglewood'	, 'wool:brown'},
		{'default:tree'	, 'wool:brown'				, 'default:tree'},
	},
	alias = {"blockwoodtatame"},

	description_stair = modceramics.translate("Stair Wood Tatame"),
	alias_stair = {"stairwoodtatame","escadadetatamedemadeira","escadatatamemadeira","escada_tatame_madeira"},
})
