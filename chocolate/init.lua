print("Hello, world! I am from chocolate init.lua!");

dofile(minetest.get_modpath("chocolate") .. "/cocoa.lua")
dofile(minetest.get_modpath("chocolate") .. "/chocolate.lua")

-- minetest.register_node("chocolate:testblock", {
-- 	decription = "Testy",
-- 	tiles = {
-- 		"chocolate_test_top.png",
-- 		"chocolate_test_bottom.png",
-- 		"chocolate_test_side.png",
-- 		"chocolate_test_side.png",
-- 		"chocolate_test_side.png",
-- 		"chocolate_test_side.png"
-- 	},
-- 	groups = {cracky = 1}
-- })