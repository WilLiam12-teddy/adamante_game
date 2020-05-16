minetest.register_node("candycane:candy_block2", {
	description = "Candy Block",
	tiles = {"candycane_block.png"},
	on_use = minetest.item_eat(2),
	is_ground_content = true,
	groups = {cracky=3},
})
minetest.register_node("candycane:candy_block", {
	description = "Candy Block",
	tiles = {"default_stone.png"},
	on_use = minetest.item_eat(2),
	is_ground_content = true,
	groups = {cracky=3},
})

-- minetest.register_node("candycane:candy_cane", {
-- 	description = "Candy Cane",
-- 	drawtype = "plantlike",
-- 	inventory_image = "candycane_cane.png",
-- 	paramtype="light",
-- 	visual_scale = 1.0,
-- 	tiles = {"candycane_cane.png"},
-- 	on_use = minetest.item_eat(4),
-- 	groups = {cracky=3},
-- })

--Tool
minetest.register_tool("candycane:pick_candy", {
	description = "Candy Pickaxe",
	inventory_image = "candycane_tool_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("candycane:shovel_candy", {
	description = "Candy Shovel",
	inventory_image = "candycane_tool_shovel.png",
	wield_image = "candycane_tool_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("candycane:sword_candy", {
	description = "Candy Sword",
	inventory_image = "candycane_tool_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})

minetest.register_tool("candycane:axe_candy", {
	description = "Candy Axe",
	inventory_image = "candycane_tool_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

--Craft
minetest.register_craft({
	output = 'candycane:pick_candy',
	recipe = {
		{'candycane:candy_block2', 'candycane:candy_block2', 'candycane:candy_block2'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'candycane:axe_candy',
	recipe = {
		{'candycane:candy_block2', 'candycane:candy_block2'},
		{'candycane:candy_block2', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'candycane:sword_candy',
	recipe = {
		{'candycane:candy_block2'},
		{'candycane:candy_block2'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'candycane:shovel_candy',
	recipe = {
		{'candycane:candy_block2'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "candycane:candy_cane",
	recipe = "candycane:candy_block2",
})

--Ore
-- minetest.register_ore({
-- 	ore_type       = "scatter",
-- 	ore            = "candycane:candy_block",
-- 	wherein        = "default:stone",
-- 	clust_scarcity = 8*8*8,
-- 	clust_num_ores = 8,
-- 	clust_size     = 3,
-- 	height_min     = -31000,
-- 	height_max     = 64,
-- })

