local pictures = {  ["nacional"]="Nacional",
                    ["nacional_old"]="Nacional Old",
}

for name,desc in pairs(pictures) do
    minetest.register_node("images:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 4.0,
        tiles = {name..".png",},
        use_texture_alpha = true,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        light_source = 5,
        is_ground_content = false,
        selection_box = {
            type = "wallmounted",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
        },
        groups = {cracky=3,dig_immediate=3},
        on_construct = function(pos)
            local msg = desc
            local meta = minetest.get_meta(pos)
            --meta:set_string("text", msg)
            meta:set_string("infotext", '"' .. msg .. '"')
        end,
    })
end

local pictures = {  ["nacional_grande"]="Nacional",
                    ["nacional_old_grande"]="Nacional Old Grande",
}

for name,desc in pairs(pictures) do
    minetest.register_node("images:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 5.0,
        tiles = {name..".png",},
        use_texture_alpha = true,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        light_source = 5,
        is_ground_content = false,
        selection_box = {
            type = "wallmounted",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
        },
        groups = {cracky=3,dig_immediate=3},
        on_construct = function(pos)
            local msg = desc
            local meta = minetest.get_meta(pos)
            --meta:set_string("text", msg)
            meta:set_string("infotext", '"' .. msg .. '"')
        end,
    })
end

local pictures = {  ["nacional_grandao"]="Nacional",
                    ["nacional_old_grandao"]="Nacional Old Grandao",
}

for name,desc in pairs(pictures) do
    minetest.register_node("images:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 6.0,
        tiles = {name..".png",},
        use_texture_alpha = true,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        light_source = 5,
        is_ground_content = false,
        selection_box = {
            type = "wallmounted",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
        },
        groups = {cracky=3,dig_immediate=3},
        on_construct = function(pos)
            local msg = desc
            local meta = minetest.get_meta(pos)
            --meta:set_string("text", msg)
            meta:set_string("infotext", '"' .. msg .. '"')
        end,
    })
end

local pictures = {  ["pizza"]="Pizza",
                    ["flower"]="Flower",
                    ["chocolate"]="Chocolate",
                    ["family"]="Family",
                    ["padaria"]="Padaria",
}

for name,desc in pairs(pictures) do
    minetest.register_node("images:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 3.0,
        tiles = {name..".png",},
        use_texture_alpha = true,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        light_source = 5,
        is_ground_content = false,
        selection_box = {
            type = "wallmounted",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
        },
        groups = {cracky=3,dig_immediate=3},
        on_construct = function(pos)
            local msg = desc
            local meta = minetest.get_meta(pos)
            --meta:set_string("text", msg)
            meta:set_string("infotext", '"' .. msg .. '"')
        end,
    })
end

minetest.register_node("nacional:block", {
    description = "block",
    tiles = {"block.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})