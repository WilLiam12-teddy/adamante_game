  -- Crafts
 
minetest.register_craft({
	output = "nice_doors:iron 2",
	recipe = {
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""},
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""},
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:zinc 2",
	recipe = {
		{"technic:zinc_ingot", "technic:zinc_ingot", ""},
		{"technic:zinc_ingot", "technic:zinc_ingot", ""},
		{"technic:zinc_ingot", "technic:zinc_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:stainless_steel 2",
	recipe = {
		{"technic:stainless_steel_ingot", "technic:stainless_steel_ingot", ""},
		{"technic:stainless_steel_ingot", "technic:stainless_steel_ingot", ""},
		{"technic:stainless_steel_ingot", "technic:stainless_steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:copper 2",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", ""},
		{"default:copper_ingot", "default:copper_ingot", ""},
		{"default:copper_ingot", "default:copper_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:tin 2",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", ""},
		{"default:tin_ingot", "default:tin_ingot", ""},
		{"default:tin_ingot", "default:tin_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:iron_locked 2",
	recipe = {
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", "technic:wrought_iron_ingot"},
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""},
		{"technic:carbon_steel_ingot", "technic:carbon_steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:zinc_locked 2",
	recipe = {
		{"technic:zinc_ingot", "technic:zinc_ingot", "technic:wrought_iron_ingot"},
		{"technic:zinc_ingot", "technic:zinc_ingot", ""},
		{"technic:zinc_ingot", "technic:zinc_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:stainless_steel_locked 2",
	recipe = {
		{"technic:stainless_steel_ingot", "technic:stainless_steel_ingot", "technic:wrought_iron_ingot"},
		{"technic:stainless_steel_ingot", "technic:stainless_steel_ingot", ""},
		{"technic:stainless_steel_ingot", "technic:stainless_steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:copper_locked 2",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "technic:wrought_iron_ingot"},
		{"default:copper_ingot", "default:copper_ingot", ""},
		{"default:copper_ingot", "default:copper_ingot", ""}
	}
})

minetest.register_craft({
	output = "nice_doors:tin_locked 2",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "technic:wrought_iron_ingot"},
		{"default:tin_ingot", "default:tin_ingot", ""},
		{"default:tin_ingot", "default:tin_ingot", ""}
	}
})
