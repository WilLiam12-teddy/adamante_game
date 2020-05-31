 local wood_door_locked = {   -- , Description , Image
	{"Acacia" , "acacia"},
	{"Aspen", "aspen"},
	{"Birch" , "birch"},
	{"Beech", "beech"},
	{"Dark_Oak" , "dark_oak"},
	{"Jungle" , "jungle"},
	{"Spruce" , "spruce"},
	{"Wood" , "wood"},
    {"Fir", "fir"},
    {"Pine", "pine"},
    {"Willow", "willow"},
    {"Sequoia", "sequoia"},
}

for i in ipairs(wood_door_locked) do
	local desc = wood_door_locked[i][1]
	local img = wood_door_locked[i][2]

doors.register_door("nice_doors:"..img.."_locked", {
	description = desc.." Locked",
	inventory_image = "nice_doors_"..img.."_inv.png",
	groups = {choppy=2,cracky=2,wood_door_locked=1},
	tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
	protected = true,
})
end

 local wood_door = {   -- , Description , Image
	{"Acacia" , "acacia"},
	{"Aspen", "aspen"},
	{"Birch" , "birch"},
	{"Beech", "beech"},
	{"Dark_Oak" , "dark_oak"},
	{"Jungle" , "jungle"},
	{"Spruce" , "spruce"},
	{"Wood" , "wood"},
    {"Fir", "fir"},
    {"Pine", "pine"},
    {"Willow", "willow"},
    {"Sequoia", "sequoia"},
}

for i in ipairs(wood_door) do
	local desc = wood_door[i][1]
	local img = wood_door[i][2]

doors.register_door("nice_doors:"..img, {
	description = desc,
	inventory_image = "nice_doors_"..img.."_inv.png",
	groups = {choppy=2,cracky=2,wood_door_locked=1},
	tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
	protected = false,
})
end
