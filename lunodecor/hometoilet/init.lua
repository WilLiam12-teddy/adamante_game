minetest.register_node("hometoilet:toilet", {
    description = "Vaso Sanitário (Toilet)",
    tiles = { 
        "marble.png", "marble.png", 
        "marble_s1.png", "marble_s1.png", 
        "marble_s2.png", "marble_s2.png",
    },
    drawtype = "nodebox",
    sunlight_propagates = false,
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.20, -0.50, -0.20,  0.20, -0.45,  0.50, },
            { -0.10, -0.45, -0.10,  0.10,  0.00,  0.50, },
            { -0.30, -0.20, -0.30,  0.30,  0.00,  0.35, },
            { -0.25,  0.00, -0.25,  0.25,  0.05,  0.25, },
            { -0.30,  0.00,  0.30,  0.30,  0.40,  0.50, },
            { -0.05,  0.40,  0.35,  0.05,  0.45,  0.45, },
        },
    },
    drop = "hometoilet:toilet",
    groups = {cracky=3,},
    sounds = default.node_sound_stone_defaults(),
    on_punch = function (pos, node, puncher)
        node.name = "hometoilet:toilet_open"
        minetest.set_node(pos, node)
        minetest.env:get_meta(pos):set_string("infotext", "Vaso Sanitário (toilet) => Puxe a descarga e baixe a tampa para não feder!!!")
    end,
	after_place_node = function(pos, placer, itemstack)
		minetest.env:get_meta(pos):set_string("infotext", "Vaso Sanitário (toilet) => Único trono mágico que todo poeta se inspira, todo fracote enfrenta, e que todo valentão se cága.")
	end,

})

minetest.register_node("hometoilet:toilet_open", {
    tiles = {
        "marble_top_toilet.png", "marble.png",
        "marble_sb1.png", "marble_sb1.png",
        "marble_sb2.png", "marble_sb2.png",
    },
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -0.20, -0.50, -0.20,  0.20, -0.45,  0.50, },
            { -0.10, -0.45, -0.10,  0.10, -0.20,  0.50, },
            { -0.10, -0.20,  0.30,  0.10,  0.00,  0.50, },
            { -0.30, -0.20,  0.10,  0.30,  0.00,  0.35, },
            { -0.30, -0.20, -0.30, -0.10, -0.15,  0.10, },
            { -0.10, -0.20, -0.30,  0.10, -0.15, -0.10, },
            {  0.10, -0.20, -0.30,  0.30, -0.15,  0.10, },
            { -0.30, -0.15, -0.30, -0.20,  0.00,  0.10, },
            { -0.20, -0.15, -0.30,  0.20,  0.00, -0.20, },
            {  0.20, -0.15, -0.30,  0.30,  0.00,  0.10, },
            { -0.25,  0.00,  0.20,  0.25,  0.50,  0.25, },
            { -0.30,  0.00,  0.30,  0.30,  0.40,  0.50, },
        },
    },
    drop = "hometoilet:toilet",
    groups = {cracky = 3,},
    --sounds = {dig = "3dforniture_dig_toilet",  gain=0.5},
    sounds = default.node_sound_stone_defaults(),
    on_punch = function (pos, node, puncher)
        node.name = "hometoilet:toilet"
        minetest.set_node(pos, node)
        minetest.env:get_meta(pos):set_string("infotext", "Vaso Sanitário (toilet) => Único trono mágico que todo poeta se inspira, todo fracote enfrenta, e que todo valentão se cága.")
        minetest.sound_play("toilet_flush", {object=puncher, max_hear_distance=3.0,})
    end,
})

minetest.register_craft({
	output = 'hometoilet:toilet',
	recipe = {
        {""						, ""							, "bucket:bucket_water"},
        { "default:wood"	, ""							, "default:wood" },
        { "default:cobble"	, "bucket:bucket_empty"	, "default:cobble" },
	}
})

minetest.register_alias("toilet"				,"hometoilet:toilet")
minetest.register_alias("vasosanitario"	,"hometoilet:toilet")
minetest.register_alias("sanitario"			,"hometoilet:toilet")
