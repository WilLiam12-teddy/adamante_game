print(" ")
print("!!!!!!!!!!!!!!!!!!!!!!!!!")
print("!!!!                 !!!!")
print("!!!! Elektra's Nodes !!!!")
print("!!!!                 !!!!")
print("!!!!!!!!!!!!!!!!!!!!!!!!!")
print(" ")



minetest.register_node("elektra:basket", {
    description = "empty basket",
	tiles = {
		"elektra_basket_top.png",
		"elektra_basket_side.png",
		"elektra_basket_side.png",
		"elektra_basket_side.png",
		"elektra_basket_side.png",
		"elektra_basket_side.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox1
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox2
			{0.4375, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox3
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox4
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox5
		}
	},
    is_ground_content = false,
    groups = {cracky = 1, snappy = 1, crumbly = 1},
})
minetest.register_alias("basket:empty","elektra:basket")



minetest.register_node("elektra:cake", {
    description="Birthday Cake",
    is_ground_content = false,
	tiles = { 
		"elektra_cake_top.png",
		"elektra_cake_bottom.png",
		"elektra_cake_side.png",
		"elektra_cake_side.png",
		"elektra_cake_side.png",
		"elektra_cake_side.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.0625, 0.4375}, -- NodeBox1
			{-0.3125, -0.5, -0.3125, 0.3125, 0.1875, 0.3125}, -- NodeBox2
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox3
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox4
		},
	},
    is_ground_content = false,
	light_source = 5,
	on_use = minetest.item_eat(7),
    groups = {cracky = 1, snappy = 1, crumbly = 1},
})
minetest.register_alias("spell:cake","elektra:cake")


