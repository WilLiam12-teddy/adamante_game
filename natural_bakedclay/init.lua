minetest.register_node("natural_bakedclay:clay", {
    description = "Argila Normal",
    tiles = {"argila_normal.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})

minetest.register_craft({
    type = "shaped",
    output = "natural_bakedclay:clay",
    recipe = {
        {"", "",""},
    }
})