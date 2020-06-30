minetest.register_node("bompreco_vegan:peanut_butter", {
	description = ("Manteiga de amendoim"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_peanut_butter.png"},
	inventory_image = "cucina_vegana_peanut_butter.png",
	wield_image = "cucina_vegana_peanut_butter.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(10),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})