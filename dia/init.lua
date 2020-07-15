minetest.register_node("dia:cocacola", {
	description = ("Coca-Cola"),
	drawtype = "plantlike",
	tiles = {"cocacola.png"},
	inventory_image = "cocacola.png",
	wield_image = "cocacola.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})

minetest.register_craftitem("dia:cookie", {
		description = "Biscoito (cookie)",
		on_use = minetest.item_eat(2),
		groups={food=3,crumbly=3},
		walkable = false,
		sunlight_propagates = true,
                inventory_image = "cookie.png",
		drawtype="nodebox",
		paramtype = "light",
		node_box = cookies_box
})

minetest.register_node("dia:snackmachine", {
	description = ("Maquina de Doces"),
  drawtype = "mesh",
	mesh = "snack_machine.obj",
  inventory_image = "snack_machine_inv.png",
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 15,
  tiles = {"snack_machine.png"},
  groups = {snappy=3},
})

minetest.register_node("dia:doritos", {
	description = ("Pacote de Doritos"),
	drawtype = "plantlike",
	tiles = {"doritos.png"},
	inventory_image = "doritos.png",
	wield_image = "doritos.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})

minetest.register_node("dia:snackmachine2", {
	description = ("Maquina de Doces e Snacks 2"),
  drawtype = "mesh",
	mesh = "snack_machine.obj",
  inventory_image = "snack_machine2_inv.png",
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 15,
  tiles = {"snack_machine2.png"},
  groups = {snappy=3},
})

local pictures = {  ["logo"]="Logo",
}

for name,desc in pairs(pictures) do
    minetest.register_node("dia:"..name, {
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

local pictures = {  ["logo_mini"]="Dia",
}

for name,desc in pairs(pictures) do
    minetest.register_node("dia:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 0.9,
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

local pictures = {  ["atelogo"]="Ate Logo!",
                    ["economize"]="Economize",
                    ["novodia"]="Novo Dia",
                    ["voltamosabaixar"]="Voltamos a Baixar os Precos",
                    ["bem_vindo"]="Bem Vindo",
                    ["frase1"]="Frase 1",
                    ["frase2"]="Frase 2",
                    ["frase3"]="Frase 3",
                    ["frescor"]="Frescor",
}

for name,desc in pairs(pictures) do
    minetest.register_node("dia:"..name, {
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


local pictures = {  ["bem_vindo_grande"]="Bem-Vindo",
}

for name,desc in pairs(pictures) do
    minetest.register_node("dia:"..name, {
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

minetest.register_node("dia:icecream_freezer", {
	description = ("Ice Cream Freezer"),
        light_source = 17,
        groups = {snappy=3},
        inventory_image = "icecream_freezer_inv.png",
        tiles = {
		"icecream_top.png",
		"icecream_bottom.png",
		"icecream_front.png",
		"icecream_front.png",
		"icecream_true.png",
		"icecream_true.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}, -- Freezer
		}
	},
	infotext=("Ice Cream Freezer"),
    selection_box = f_box,
	collision_box = f_box,
	inventory = {
		size=50,
		lockable=true,
	},
})

minetest.register_node("dia:arroz", {
	description = ("Arroz Dia"),
	drawtype = "plantlike",
	tiles = {"arroz.png"},
	inventory_image = "arroz.png",
	wield_image = "arroz.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})

minetest.register_node("dia:frango", {
	description = ("Frango Dia"),
	drawtype = "plantlike",
	tiles = {"frango.png"},
	inventory_image = "frango.png",
	wield_image = "frango.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})

minetest.register_node("dia:avela", {
	description = ("Creme de avela DIA"),
	drawtype = "plantlike",
	tiles = {"creme_de_avela.png"},
	inventory_image = "creme_de_avela.png",
	wield_image = "creme_de_avela.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(1),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, food_sweet = 1, food_butter = 1, eatable = 1},
})

local pictures = {  ["padaria"]="Padaria",
}

for name,desc in pairs(pictures) do
    minetest.register_node("dia:"..name, {
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