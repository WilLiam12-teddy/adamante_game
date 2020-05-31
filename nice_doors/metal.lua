 local metal_door_locked = {   -- , Description , Image
 
    {"Iron " ,            "iron"},
    {"Zinc",              "zinc"},
    {"Stainless Steel",   "stainless_steel"},
    {"Copper",            "copper"},
    {"Tin",               "tin"},
}

for i in ipairs(metal_door_locked) do
	local desc = metal_door_locked[i][1]
	local img = metal_door_locked[i][2]

doors.register_door("nice_doors:"..img.."_locked", {
	description = desc.." Locked",
	inventory_image = "nice_doors_"..img.."_inv.png",
	groups = {choppy=2,cracky=2,metal_door_locked=1},
	tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
	protected = true,
})
end

local metal_door = {   -- , Description , Image
 
    {"Iron " ,            "iron"},
    {"Zinc",              "zinc"},
    {"Stainless Steel",   "stainless_steel"},
    {"Copper",            "copper"},
    {"Tin",               "tin"},
}

for i in ipairs(metal_door) do
	local desc = metal_door[i][1]
	local img = metal_door[i][2]

doors.register_door("nice_doors:"..img, {
	description = desc,
	inventory_image = "nice_doors_"..img.."_inv.png",
	groups = {choppy=2,cracky=2,metal_door=1},
	tiles = {{ name = "nice_doors_"..img..".png", backface_culling = false }},
	protected = false,
})
end
