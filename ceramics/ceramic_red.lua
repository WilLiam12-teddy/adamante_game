modceramics.register_ceramic("red", {
	description = modceramics.translate("Ceramic Red"),
	tiles = {"tex_azulejo_vermelho.png"},
	is_ground_content = true,
	groups = {ceramic=1, cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
	recipe = {
		{'default:stone'		, 'wool:red'	, 'default:stone'},
		{'wool:red'			, 'wool:white'	, 'wool:red'},
		{'default:stone'		, 'wool:red'	, 'default:stone'},
	},
	alias = {"blockred"},

	description_stair = modceramics.translate("Stair Red"),
	alias_stair = {"stairred","escadariavermelha","escadaria_vermelha"},
})
