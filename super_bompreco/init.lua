local pictures = {  ["farmacia"]="Farmacia Bompreco",
                    ["comida"]="Comida",
                    ["comida2"]="Comida2",
                    ["comida3"]="Comida3",
                    ["comida4"]="Comida4",
                    ["comida5"]="Comida5",
                    ["comida6"]="Comida6",
                    ["comida7"]="Comida7",
                    ["comida8"]="Comida8",
                    ["flores"]="Flores",
                    ["frase1"]="Frase1",
                    ["frase2"]="Frase2",
                    ["frase3"]="Frase3",
                    ["frase4"]="Frase4",
                    ["frase5"]="Frase5",
}

for name,desc in pairs(pictures) do
    minetest.register_node("super_bompreco:"..name, {
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

local pictures = {  ["nacional"]="Nacional",
}

for name,desc in pairs(pictures) do
    minetest.register_node("super_bompreco:"..name, {
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

local pictures = {  ["nacional_grande"]="Nacional grande",
}

for name,desc in pairs(pictures) do
    minetest.register_node("super_bompreco:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 12.0,
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

minetest.register_node("super_bompreco:bloco", {
    description = "Bloco de Paredes.",
    tiles = {"block1.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})