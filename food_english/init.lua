-- ENGLISH FOODS
-- A mod written by rubenwardy that adds
-- english food to the minetest game
-- =====================================
-- >> food_english/init.lua
-- Adds pizzas, hamburgers, soda, etc
-- =====================================

print("English Foods - Version 0.1")

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

food.module("english_breakfast", function()
	local k = 7/8
	minetest.register_node("food_english:breakfast", {
		description = S("English Breakfast"),
		drawtype = "nodebox",
		inventory_image = "food_english_breakfast.png",
		wield_image = "food_english_breakfast.png",
		tiles = {
			"food_english_breakfast.png",
			"food_english_breakfast.png"
		},
		paramtype = "light",
		walkable = true,
		groups = {snappy = 3, food = 1},
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.25*k,   -0.5, -0.5*k,    0.25*k,   -0.48, 0.5*k    },
				{ -0.375*k,  -0.5, -0.4375*k, 0.375*k,  -0.48, 0.4375*k },
				{ -0.5*k,    -0.5, -0.25*k,   0.5*k,    -0.48, 0.25*k   },
				{ -0.4375*k, -0.5, -0.375*k,  0.4375*k, -0.48, 0.375*k  },
				{ -0.25*k,   -0.5, -0.5*k,    0.25*k,   -0.48, 0.5*k    }
			}
		},
		--selection_box = {
		--	type = "fixed",
		--	fixed = { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 },
		--},
		on_use = food.item_eat(10),
		on_place = minetest.rotate_node
	})
	minetest.register_craft({
		output = "food_english:breakfast",
		type = "shapeless",
		recipe = {
			"group:food_bread",
			"group:food_bread",
			"group:food_meat",
			"group:food_meat",
			"group:food_potato",
			"group:food_egg",
		}
	})
end)
