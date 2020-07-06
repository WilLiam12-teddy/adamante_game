minetest.register_node("big:cocacola", {
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

minetest.register_craftitem("big:cookie", {
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

minetest.register_node("big:snackmachine", {
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

minetest.register_node("big:doritos", {
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

minetest.register_node("big:snackmachine2", {
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

local pictures = {  ["farmacia"]="Farmacia",
}

for name,desc in pairs(pictures) do
    minetest.register_node("big:"..name, {
        description = desc,
        drawtype = "signlike",
        inventory_image = name..".png",
        wield_image = name..".png",
        visual_scale = 2.0,
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

minetest.register_node("big:feijao", {
	description = ("Feijao Great Value"),
	drawtype = "plantlike",
	tiles = {"feijao.png"},
	inventory_image = "feijao.png",
	wield_image = "feijao.png",
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

minetest.register_node("big:block1", {
    description = "Block",
    tiles = {"block1.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})

minetest.register_node("big:block2", {
    description = "Block 2",
    tiles = {"block2.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})

minetest.register_node("big:box", {
	description = ("Item"),
	tiles = {
		'cookies.png',
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0, 0.3125},
		}
	},
	groups = { snappy = 3 },
	infotext=("Cardboard box"),
	inventory = {
		size=8,
	},
})

local pictures = {  ["logo"]="BIG Logo",
}

for name,desc in pairs(pictures) do
    minetest.register_node("big:"..name, {
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