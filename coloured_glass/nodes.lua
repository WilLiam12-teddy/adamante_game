-- Coloured Glass

-- Coloured node definition
	
local dye = {
	{"white",      "White"},
	{"silver",     "Silver"},
	{"grey",       "grey"},
	{"black",      "Black"},
	{"purple",     "Purple"},
	{"blue",       "Blue"},
	{"cyan",       "Cyan"},
	{"green",      "green"},
	{"lime",       "Lime"},
	{"yellow",     "Yellow"},
	{"brown",      "Brown"},
	{"orange",     "Orange"},
	{"red",        "Red"},
	{"magenta",    "Magenta"},
	{"pink",       "Pink"},
    {"light_blue", "Light Blue"},
}

for _, dye in pairs(dye) do

local stairs_mod = minetest.get_modpath("stairs")
local stairsplus_mod = minetest.get_modpath("moreblocks")
	and minetest.global_exists("stairsplus")
	
	minetest.register_node("coloured_glass:" .. dye[1] .. "", {
		description = dye[2] .. "Coloured Glass",
		tiles = {"coloured_glass_" .. dye[1] ..".png"},
		groups = {cracky = 3, colouredglass = 1, oddly_breakable_by_hand=3},
        use_texture_alpha = true,
        sunlight_propagates = true,
        drawtype = "glasslike",
        paramtype = "light",
		sounds = default.node_sound_glass_defaults(),
	})

-- craft from dye and any glass

minetest.register_craft({
    output = "coloured_glass:" .. dye[1] .. "",
	recipe = {
		{"group:colouredglass", "dye:" .. dye[1], ""},
		{"", "", ""},
		{"", "", ""}
	},
})

minetest.register_craft({
    output = "coloured_glass:" .. dye[1] .. "",
	recipe = {
		{"default:glass", "dye:" .. dye[1], ""},
		{"", "", ""},
		{"", "", ""}
	},
})
	
-- register stairsplus stairs if found
	if stairsplus_mod then

		stairsplus:register_all("coloured_glass", "coloured_glass_" .. dye[1], "coloured_glass:" .. dye[1], {
			description = dye[2] .. " Coloured Glass",
			tiles = {"coloured_glass_" .. dye[1] .. ".png"},
			groups = {cracky = 3, oddly_breakable_by_hand=3},
			use_texture_alpha = true,
            sunlight_propagates = true,
            drawtype = "glasslike",
            paramtype = "light",
			sounds = default.node_sound_stone_defaults(),
		})

stairsplus:register_alias_all("coloured_glass", dye[1], "coloured_glass", "coloured_glass_" .. dye[1])
minetest.register_alias("stairs:slab_coloured_glass_".. dye[1], "coloured_glass:slab_coloured_glass_" .. dye[1])
minetest.register_alias("stairs:stair_coloured_glass_".. dye[1], "coloured_glass:stair_coloured_glass_" .. dye[1])
end
end
