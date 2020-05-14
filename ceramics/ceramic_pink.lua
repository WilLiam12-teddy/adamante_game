modceramics.register_ceramic("pink", {
	description = modceramics.translate("Ceramic Pink"),
	tiles = {"tex_azulejo_rosa.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'	, 'wool:pink'					, 'default:stone'},
		{'wool:pink'	   , 'default:mese_crystal' 	, 'wool:pink'},
		{'default:stone'	, 'wool:pink'					, 'default:stone'},
	},
	alias = {"blockpink"},

	description_stair = modceramics.translate("Stair Pink"),
	alias_stair = {"stairpink","escadariarosa","escadaria_rosa"},
})
