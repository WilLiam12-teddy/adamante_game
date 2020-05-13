 local glass_door_locked = {   -- , Description , Image
	{"Clear",         "clear"},
	{"Blue",          "blue"},
	{"Black",         "black"},
	{"Brown",         "brown"},
	{"Cyan",          "cyan"},
	{"Green",         "green"},
	{"Grey",          "grey"},
	{"Light_blue",    "light_blue"},
	{"Lime",          "lime"},
	{"Magenta",       "magenta"},
	{"Orange",        "orange"},
	{"Pink",          "pink"},
	{"Purple",        "purple"},
	{"Red",           "red"},
	{"Silver",        "silver"},
	{"White",         "white"},
	{"Yellow",        "yellow"},
}

for i in ipairs(glass_door_locked) do
	local desc = glass_door_locked[i][1]
	local img = glass_door_locked[i][2]

doors.register_door("nice_doors:glass_"..img.."_locked", {
	description = desc.." Locked",
	inventory_image = "nice_doors_"..img.."_inv.png",
	groups = {choppy=2, cracky=2, door=1, glass_door_locked=1},
	use_texture_alpha = true,
        sunlight_propagates = true,
        drawtype = "glasslike",
        paramtype = "light",
	tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
	protected = true,
})
end

 local glass_door = {   -- , Description , Image
	{"Clear",         "clear"},
	{"Blue",          "blue"},
	{"Black",         "black"},
	{"Brown",         "brown"},
	{"Cyan",          "cyan"},
	{"Green",         "green"},
	{"Grey",          "grey"},
	{"Light_blue",    "light_blue"},
	{"Lime",          "lime"},
	{"Magenta",       "magenta"},
	{"Orange",        "orange"},
	{"Pink",          "pink"},
	{"Purple",        "purple"},
	{"Red",           "red"},
	{"Silver",        "silver"},
	{"White",         "white"},
	{"Yellow",        "yellow"},
}

for i in ipairs(glass_door) do
	local desc = glass_door[i][1]
	local img = glass_door[i][2]

doors.register_door("nice_doors:glass_"..img, {
	description = desc,
	inventory_image = "nice_doors_"..img.."_inv.png",
	groups = {choppy=2, cracky=2, door=1, glass_door=1},
	use_texture_alpha = true,
        sunlight_propagates = true,
        drawtype = "glasslike",
        paramtype = "light",
	tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
	protected = false,
})
end
