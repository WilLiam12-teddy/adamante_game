modceramics.register_ceramic("purple", {
	description = modceramics.translate("Ceramic Purple"),
	tiles = {"tex_azulejo_purpura.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'	, 'wool:violet'		, 'default:stone'},
		{'wool:violet'	   , 'default:obsidian' , 'wool:violet'},
		{'default:stone'	, 'wool:violet'		, 'default:stone'},
	},
	alias = {"blockpurple"},

	description_stair = modceramics.translate("Stair Purple"),
	alias_stair = {"stairpurple","escadariapurpura","escadaria_purpura"},
})
