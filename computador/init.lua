--Modern PC Tower
minetest.register_node("computador:tower", {
	description = ("torre de computador"),
	inventory_image = "computer_tower_inv.png",
	drawtype = "mesh",
	mesh = "computer_tower.obj",
	tiles = {"computer_tower.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	selection_box = pct_cbox,
	collision_box = pct_cbox
})

minetest.register_craft({
	output = "computador:tower",
	recipe = {
		{ "basic_materials:plastic_sheet", "default:steel_ingot", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:mese_crystal", "basic_materials:plastic_sheet" },
		{ "basic_materials:plastic_sheet", "default:steel_ingot", "basic_materials:plastic_sheet" }
	}
})

-- Some generic laptop
minetest.register_node("computador:vanio", {
	drawtype = "mesh",
	mesh = "computer_laptop.obj",
	description = "Notebook",
	inventory_image = "computer_laptop_inv.png",
	tiles = {"computer_laptop.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 4,
	groups = {snappy=3},
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.05, 0.35},
	},
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computador:vanio_off"
		minetest.set_node(pos, node)
		return itemstack
	end
})

minetest.register_node("computador:vanio_off", {
	drawtype = "mesh",
	mesh = "computer_laptop_closed.obj",
	tiles = {"computer_laptop.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, not_in_creative_inventory=1},
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, -0.4, 0.25},
	},
	drop = "computador:vanio",
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computador:vanio"
		minetest.set_node(pos, node)
		return itemstack
	end
})

minetest.register_craft({
	output = "computador:vanio",
	recipe = {
		{ "basic_materials:plastic_sheet", "", "" },
		{ "default:glass", "", "" },
		{ "basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet" }
	}
})