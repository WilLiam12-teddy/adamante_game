-- MODERN FOODS
-- A mod written by rubenwardy that adds
-- modern food to the minetest game
-- =====================================
-- >> food_modern/init.lua
-- Adds pizzas, hamburgers, soda, etc
-- =====================================

print("Modern Foods - Version 0.1")

if not food or not food.version or food.version < 2.3 then
	error("You need to update your version of the Food mod - it is too old")
end

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function ( s ) return s end
end

food.module("pizza", function()
	minetest.register_node("food_modern:pizza", {
		description = S("Pizza"),
		drawtype = "nodebox",
		tiles = {
			"food_modern_pizza.png",
			"food_modern_pizza_sides.png"
		},
		paramtype = "light",
		walkable = true,
		groups = {snappy = 3, food = 1},
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.25,   -0.5, -0.5,    0.25,   -0.48, 0.5    },
				{ -0.375,  -0.5, -0.4375, 0.375,  -0.48, 0.4375 },
				{ -0.5,    -0.5, -0.25,   0.5,    -0.48, 0.25   },
				{ -0.4375, -0.5, -0.375,  0.4375, -0.48, 0.375  },
				{ -0.25,   -0.5, -0.5,    0.25,   -0.48, 0.5    }
			}
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 },
		},
		on_use = food.item_eat(10),
		on_place = minetest.rotate_node
	})

	minetest.register_craftitem("food_modern:pizza_raw", {
		description = S("Raw Pizza"),
		inventory_image = "food_modern_pizza_raw.png"
	})

	minetest.register_craft({
		output = "food_modern:pizza_raw",
		recipe = {
			{"group:food_cheese", "group:food_meat", "group:food_cheese"},
			{"group:food_tomato", "group:food_tomato", "group:food_tomato"},
			{"group:food_flour", "group:food_flour", "group:food_flour"}
		}
	})

	minetest.register_craft({
		output = "food_modern:pizza",
		type = "cooking",
		recipe = "food_modern:pizza_raw"
	})
end)

food.module("hamburger", function()
	minetest.register_craftitem("food_modern:hamburger", {
		description = S("Hamburger"),
		groups = {food=1},
		on_use = food.item_eat(6),
		inventory_image = "food_burger.png"
	})
	minetest.register_craft({
		output = "food_modern:hamburger",
		recipe = {
			{"group:food_bread"},
			{"group:food_meat"},			
			{"group:food_bread"}
		}
	})
end)
