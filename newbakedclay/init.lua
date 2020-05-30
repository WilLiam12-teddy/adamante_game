-- New Baked Clay 

 local clay = {
	{"newwhite",      "NewWhite"},
	{"newsilver",     "NewSilver"},
	{"newgrey",       "NewGrey"},
	{"newblack",      "NewBlack"},
	{"newpurple",     "NewPurple"},
	{"newblue",       "NewBlue"},
	{"newcyan",       "NewCyan"},
	{"newgreen",      "Newgreen"},
	{"newlime",       "NewLime"},
	{"newyellow",     "NewYellow"},
	{"newbrown",      "NewBrown"},
	{"neworange",     "NewOrange"},
	{"newred",        "NewRed"},
	{"newmagenta",    "NewMagenta"},
	{"newpink",       "NewPink"},
    {"light_blue", "Light Blue"},
}

local stairs_mod = minetest.get_modpath("stairs")
local stairsplus_mod = minetest.get_modpath("moreblocks")
	and minetest.global_exists("stairsplus")

for _, clay in pairs(clay) do

	-- node definition

	minetest.register_node("newbakedclay:" .. clay[1], {
		description = clay[2] .. " New Baked Clay",
		tiles = {"baked_clay_" .. clay[1] ..".png"},
		groups = {cracky = 3, newbakedclay = 1},
		sounds = default.node_sound_stone_defaults(),
	})

-- craft from dye and any baked clay
	minetest.register_craft({
		output = "newbakedclay:" .. clay[1],
		recipe = {
			{"group:newbakedclay", "dye:" .. clay[1], ""},
			{"", "", ""},
			{"", "", ""}
		},
	})

	
-- register stairsplus stairs if found
	if stairsplus_mod then

		stairsplus:register_all("newbakedclay", "baked_clay_" .. clay[1], "newbakedclay:" .. clay[1], {
			description = clay[2] .. " New Baked Clay",
			tiles = {"baked_clay_" .. clay[1] .. ".png"},
			groups = {cracky = 3},
			sounds = default.node_sound_stone_defaults(),
		})

		stairsplus:register_alias_all("newbakedclay", clay[1], "newbakedclay", "baked_clay_" .. clay[1])
		minetest.register_alias("stairs:slab_bakedclay_".. clay[1], "newbakedclay:slab_baked_clay_" .. clay[1])
		minetest.register_alias("stairs:stair_bakedclay_".. clay[1], "newbakedclay:stair_baked_clay_" .. clay[1])

	end
end

-- cook clay block into white baked clay

minetest.register_craft({
	type = "cooking",
	output = "newbakedclay:white",
	recipe = "default:clay",
})

-- register a few extra dye colour options

minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_grey 3",
	recipe = {"dye:black", "dye:black", "dye:white"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:grey 3",
	recipe = {"dye:black", "dye:white", "dye:white"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:green 4",
	recipe = {"default:cactus"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:black 4",
	recipe = {"default:coal_lump"}
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:brown 4",
	recipe = {"default:dry_shrub"}
})

-- 2x2 red bakedclay makes 16x clay brick
minetest.register_craft( {
	output = "default:clay_brick 16",
	recipe = {
		{"newbakedclay:red", "newbakedclay:red"},
		{"newbakedclay:red", "newbakedclay:red"},
	}
})
