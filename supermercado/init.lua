local pictures = {  ["lasanha"]="Lasanha",
                    ["hortifruti"]="Frutas",
                    ["paes"]="Padaria",
                    ["carne"]="Carnes",
                    ["vemserfeliz"]="Vem Ser Feliz",
                    ["magalu"]="MagazineLuiza",
}

for name,desc in pairs(pictures) do
    minetest.register_node("supermercado:"..name, {
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

local pictures = {  ["walmart"]="Walmart",
}

for name,desc in pairs(pictures) do
    minetest.register_node("supermercado:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 7.0,
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
