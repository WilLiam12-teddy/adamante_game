-- Spell letters & numbers by Nigel Garnett

-- code by Nigel Garnett, under MIT license, se MIT.txt 
-- or https://mit-license.org/

-- textures by Nigel Garnett, under CC by SA 3.0 Unported license. see CC_SA_3.txt
-- or https://creativecommons.org/licenses/by/3.0/legalcode


--------------------------------------------------------
--    local variables

local modname = "spell:"
local characters = {
    A = 1,
    B = 1,
    C = 1,
    D = 1,
    E = 1,
    F = 1,
    G = 1,
    H = 1,
    I = 1,
    J = 1,
    K = 1,
    L = 1,
    M = 1,
    N = 1,
    O = 1,
    P = 1,
    Q = 1,
    R = 1,
    S = 1,
    T = 1,
    U = 1,
    V = 1,
    W = 1,
    X = 1,
    Y = 1,
    Z = 1,
    [0] = 0,
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0
}

--------------------------------------------------------
for key,value in pairs(characters) do
    if value==1 then
        my_desc = "Letter_"..key
    else
        my_desc = "Number_"..key
    end
	minetest.register_node(modname.."Sign_"..key, {
		description="Sign "..my_desc,
		drawtype = "nodebox",
		node_box = {
			type = "wallmounted",
			wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
			wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
			wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
		},
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		light_source = 14,
		inventory_image = "sign_"..key..".png",
		wield_image = "sign_"..key..".png",
		tiles = { "sign_"..key..".png","sign.png","sign.png","sign.png","sign.png","sign.png", },
		groups = {cracky=1, choppy=1},
	})
end

	minetest.register_node(modname.."px_logo", {
        description="planet express logo",
		tiles = { "PX.png" },
		light_source = 14,
        inventory_image = "PX.png",
		groups = {cracky=3, choppy=3},
	})

	minetest.register_node(modname.."nigel", {
        description="Nigel",
        drawtype = "nodebox",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
            wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
            wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
        },

    	paramtype = "light",
    	paramtype2 = "wallmounted",
        wield_image = "nyje_nyje.png",
        sunlight_propagates = true,
        tiles = { "nyje_nyje.png" },
		light_source = 14,
        inventory_image = "nyje_nyje.png",
		groups = {cracky=3, choppy=3},
	})
	minetest.register_node(modname.."elektra", {
        description="Elektra",
        drawtype = "nodebox",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
            wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
            wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
        },

    	paramtype = "light",
    	paramtype2 = "wallmounted",
        wield_image = "nyje_elektra.png",
        sunlight_propagates = true,
        tiles = { "nyje_elektra.png" },
		light_source = 14,
        inventory_image = "nyje_elektra.png",
		groups = {cracky=3, choppy=3},
	})
	minetest.register_node(modname.."Sign", {
        description="Blank Sign",
        drawtype = "nodebox",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
            wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
            wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
        },

    	paramtype = "light",
    	paramtype2 = "wallmounted",
        wield_image = "sign.png",
        sunlight_propagates = true,
        tiles = { "sign.png" },
		light_source = 14,
        inventory_image = "sign.png",
		groups = {cracky=3, choppy=3},
	})


minetest.register_craft({
    output = "spell:Sign_A",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","",""},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_B",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","default:copper_ingot",""},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_C",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","",""},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_D",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","","default:copper_ingot"},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_E",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","","default:copper_ingot"},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_F",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot",""},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_G",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_H",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_I",
    recipe = {  {"dye:black","","default:copper_ingot"},
                {"","","default:copper_ingot"},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_J",
    recipe = {  {"dye:black","","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_K",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","",""},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_L",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","default:copper_ingot",""},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_M",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","",""},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_N",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","","default:copper_ingot"},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_O",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","","default:copper_ingot"},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_P",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot",""},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_Q",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_R",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_S",
    recipe = {  {"dye:black","","default:copper_ingot"},
                {"","default:copper_ingot",""},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_T",
    recipe = {  {"dye:black","","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","default:copper_ingot",""},
    }
})
minetest.register_craft({
    output = "spell:Sign_U",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","",""},
                {"","default:copper_ingot","default:copper_ingot"},
    }
})
minetest.register_craft({
    output = "spell:Sign_V",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","default:copper_ingot",""},
                {"","default:copper_ingot","default:copper_ingot"},
    }
})
minetest.register_craft({
    output = "spell:Sign_W",
    recipe = {  {"dye:black","","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
                {"","","default:copper_ingot"},
    }
})
minetest.register_craft({
    output = "spell:Sign_X",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","",""},
                {"","default:copper_ingot","default:copper_ingot"},
    }
})
minetest.register_craft({
    output = "spell:Sign_Y",
    recipe = {  {"dye:black","default:copper_ingot","default:copper_ingot"},
                {"","","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
    }
})
minetest.register_craft({
    output = "spell:Sign_Z",
    recipe = {  {"dye:black","default:copper_ingot",""},
                {"","","default:copper_ingot"},
                {"","default:copper_ingot","default:copper_ingot"},
    }
})
minetest.register_craft({
    output = "spell:Sign_1",
    recipe = {  {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","",""},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_2",
    recipe = {  {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_3",
    recipe = {  {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","",""},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_4",
    recipe = {  {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","","default:copper_ingot"},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_5",
    recipe = {  {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","","default:copper_ingot"},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_6",
    recipe = {  {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_7",
    recipe = {  {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_8",
    recipe = {  {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_9",
    recipe = {  {"default:copper_ingot","","default:copper_ingot"},
                {"default:copper_ingot","default:copper_ingot",""},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign_0",
    recipe = {  {"default:copper_ingot","","default:copper_ingot"},
                {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
                {"default:copper_ingot","","dye:black"},
    }
})
minetest.register_craft({
    output = "spell:Sign",
    recipe = {  {"","default:copper_ingot",""},
                {"","default:copper_ingot",""},
                {"","default:copper_ingot",""},
    }
})