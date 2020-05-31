local modpath = minetest.get_modpath("lighting").. DIR_DELIM

lighting = {}

dofile(modpath.."crafts.lua")

lighting = {}

function lighting.register_variants(variants, fixedDef)
  for _,variant in ipairs(variants) do
    local name = variant.name
    local def = table.copy(fixedDef)

    for k,v in pairs(variant) do
      if k ~= "name" then
        def[k] = v
      end
    end

    minetest.register_node(name, def)
  end
end

function lighting.on_place_hanging(itemstack, placer, pointed_thing, replaceName)
  local ceiling = minetest.get_node(vector.add(pointed_thing.above,
    {x=0, y=1, z=0}))

  if ceiling and ceiling.name ~= "air"
    and minetest.get_item_group(ceiling.name, "mounted_ceiling") == 0
    and not (placer and placer:get_player_control().sneak) then

    local name = itemstack:get_name()
    local fakestack = itemstack
    fakestack:set_name(replaceName)

    minetest.item_place(fakestack, placer, pointed_thing, 0)
    itemstack:set_name(name)

    return itemstack
  end

  minetest.item_place(itemstack, placer, pointed_thing, 0)
  return itemstack
end

function lighting.rotate_and_place(itemstack, placer, pointed_thing, lookup)
  local dir = minetest.dir_to_wallmounted(vector.subtract(pointed_thing.under, pointed_thing.above))
  local fDirs = lookup or {[0] = 20, 0, 16, 12, 8, 4}
  minetest.item_place(itemstack, placer, pointed_thing, fDirs[dir] or 0)
  return itemstack
end

local path = minetest.get_modpath("lighting")


-- half node
minetest.register_node('lighting:glowlight_half_white', {
	description = ("White Glowlight (thick)"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_white_tb.png',
		'glowlight_white_tb.png',
		'glowlight_thick_white_sides.png',
		'glowlight_thick_white_sides.png',
		'glowlight_thick_white_sides.png',
		'glowlight_thick_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3, oddly_breakable_by_hand = 3},
	drop="lighting:glowlight_half_white",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Quarter node

minetest.register_node('lighting:glowlight_quarter_white', {
	description = ("White Glowlight (thin)"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_white_tb.png',
		'glowlight_white_tb.png',
		'glowlight_thin_white_sides.png',
		'glowlight_thin_white_sides.png',
		'glowlight_thin_white_sides.png',
		'glowlight_thin_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3, oddly_breakable_by_hand = 3},
	drop="lighting:glowlight_quarter_white",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Glowlight small cube
minetest.register_node('lighting:glowlight_small_cube_white', {
	description = ("White Glowlight (small cube)"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_cube_white_tb.png',
		'glowlight_cube_white_tb.png',
		'glowlight_cube_white_sides.png',
		'glowlight_cube_white_sides.png',
		'glowlight_cube_white_sides.png',
		'glowlight_cube_white_sides.png'
	},
        selection_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },
        node_box = {
                type = "fixed",
                fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
        },

	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3, oddly_breakable_by_hand = 3},
	drop="lighting:glowlight_small_cube_white",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Glowlight block
minetest.register_node('lighting:glowlightblock', {
	description = ("Glowlight block"),
	drawtype = "nodebox",
	tiles = {
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png',
		'glowlight_block.png'
	},
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	light_source = LIGHT_MAX,
    groups = {cracky = 2, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_glass_defaults(),
	groups = { snappy = 3},
	drop="lighting:glowlightblock",
	  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing)
  end,
})

-- Modern cieling light
minetest.register_node("lighting:glowlight_modern", {
  description = "Modern Ceiling Light",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/4, 3/8, -1/4, 1/4, 1/2, 1/4}
  },
  tiles = {"metal_dark.png",
    "metal_dark.png^modern_block.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = LIGHT_MAX,
  groups = {cracky = 3, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing,
      {[0] = 0, 20, 12, 16, 4, 8})
  end,
})

-- Table lamps
lighting.register_variants({
  {name = "lighting:tablelamp_d",
    description = "Modern Table Lamp (dark)",
    tiles = {"metal_light_32.png^modern_tablelamp_o.png",
    "modern_tablelamp_d.png"}},
  {name = "lighting:tablelamp_l",
    description = "Modern Table Lamp (light)",
    tiles = {"metal_dark_32.png^modern_tablelamp_o.png",
    "modern_tablelamp_l.png"}},
},
{
  drawtype = "mesh",
  mesh = "modern_tablelamp.obj",
  collision_box = {
    type = "fixed",
    fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4}
  },
  paramtype = "light",
  light_source = 10,
  groups = {choppy = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_defaults(),
})

-- modern wall lamp

minetest.register_node("lighting:modern_walllamp", {
  description = "Modern Wall Lamp",
  drawtype = "mesh",
  mesh = "modern_walllamp.obj",
  collision_box = {
    type = "fixed",
    fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/8, -3/8, 1/8, 1/8, 1/4, 1/2}
  },
  tiles = {"metal_dark_32.png^modern_walllamp.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),

  on_place = function(itemstack, placer, pointed_thing)
    return lighting.rotate_and_place(itemstack, placer, pointed_thing,
      {[0] = 6, 4, 1, 3, 0, 2})
  end,
})

-- Light bars
minetest.register_node("lighting:barlight_c", {
  description = "Ceiling Bar Light (connecting)",
  drawtype = "nodebox",
  node_box = {
    type = "connected",
    fixed = {-1/8,  3/8, -1/8, 1/8,  1/2, 1/8},
    connect_front = {-1/8, 3/8, -1/2, 1/8,  1/2, -1/8},
    connect_left = {-1/2, 3/8, -1/8, -1/8, 1/2, 1/8},
    connect_back = {-1/8, 3/8, 1/8, 1/8, 1/2, 1/2},
    connect_right = {1/8, 3/8, -1/8, 1/2, 1/2, 1/8},
  },
  connects_to = {"lighting:barlight_c", "lighting:barlight_s",
    "modern:streetpost_d", ":streetpost_l"},
  tiles = {"metal_dark.png", "modern_barlight.png",
    "metal_dark.png"},
  paramtype = "light",
  light_source = LIGHT_MAX,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("lighting:barlight_s", {
  description = "Ceiling Bar Light (straight)",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/2, 3/8, -1/8, 1/2, 1/2, 1/8},
  },
  tiles = {"metal_dark.png", "modern_barlight.png",
    "metal_dark.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = LIGHT_MAX,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),
})

-- street post

lighting.register_variants({
  {name = "lighting:streetpost_d",
    description = "Street Lamp Post (dark)--connects to bar lights",
    tiles = {"metal_dark.png"}},
  {name = "lighting:streetpost_l",
    description = "Street Lamp Post (light)--connects to bar lights",
    tiles = {"metal_light.png"}}
},
{
  drawtype = "nodebox",
  node_box = {
    type = "connected",
    fixed = {-1/16, -1/2, -1/16, 1/16,  1/2, 1/16},
    connect_front = {-1/16,  3/8, -1/2, 1/16,  7/16, -1/16},
    connect_left = {-1/2, 3/8, -1/16, -1/16, 7/16, 1/16},
    connect_back = {-1/16, 3/8, 1/16, 1/16, 7/16, 1/2},
    connect_right = {1/16, 3/8, -1/16, 1/2, 7/16, 1/16},
  },
  connects_to = {"lighting:barlight_c", "lighting:barlight_s"},
  paramtype = "light",
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_metal_defaults(),
})

-- Vintage lights

minetest.register_node("lighting:vintage_lantern_f", {
  description = "Vintage Lantern (floor, wall, or ceiling)",
  drawtype = "mesh",
  mesh = "vintage_lantern_f.obj",
  tiles = {"vintage_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, -1/2, -3/16, 3/16, 1/16, 3/16}
  },
  paramtype = "light",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_glass_defaults(),

  on_place = function(itemstack, placer, pointed_thing)
		local wdir = minetest.dir_to_wallmounted(
      vector.subtract(pointed_thing.under, pointed_thing.above))
		local fakestack = itemstack

		if wdir == 0 then
			fakestack:set_name("lighting:vintage_lantern_c")
		elseif wdir == 1 then
			fakestack:set_name("lighting:vintage_lantern_f")
		else
			fakestack:set_name("lighting:vintage_lantern_w")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("lighting:vintage_lantern_f")

		return itemstack
	end,
})

minetest.register_node("lighting:vintage_lantern_c", {
  drawtype = "mesh",
  mesh = "vintage_lantern_c.obj",
  tiles = {"vintage_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/16, -3/16, 3/16, 1/2, 3/16}
  },
  selection_box = {
    type = "fixed",
    fixed = {-3/16, 0, -3/16, 3/16, 1/2, 3/16}
  },
  paramtype = "light",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3,
    not_in_creative_inventory = 1},
  sounds = default.node_sound_glass_defaults(),
  drop = "lighting:vintage_lantern_f",
})

minetest.register_node("lighting:vintage_lantern_w", {
  drawtype = "mesh",
  mesh = "vintage_lantern_w.obj",
  tiles = {"vintage_lantern.png", "metal_dark_32.png"},
  collision_box = {
    type = "fixed",
    fixed = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16}
  },
  selection_box = {
    type = "wallmounted",
    wall_bottom = {-3/16, -1/4, -5/16, 3/16, 1/8, 3/16},
    wall_side = {-1/4, -5/16, -3/16, 1/8, 3/16, 3/16},
    wall_top = {-3/16, -1/8, -5/16, 3/16, 1/4, 3/16}
  },
  paramtype = "light",
  paramtype2 = "wallmounted",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3,
    not_in_creative_inventory = 1},
  sounds = default.node_sound_glass_defaults(),
  drop = "lighting:vintage_lantern_f",
})

-- Lantern
minetest.register_node("lighting:lantern", {
	description = "Lantern",
	drawtype = "nodebox",
	tiles = {"lantern.png","lantern.png","lantern.png","lantern.png","lantern.png","lantern.png"},
	inventory_image = minetest.inventorycube("lantern_inv.png"),
	wield_image = minetest.inventorycube("lantern_inv.png"),
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = LIGHT_MAX,
	walkable = false,
	groups = {cracky = 2, dig_immediate = 3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "wallmounted",
		wall_top = {-1/6, 1/6, -1/6, 1/6, 0.5, 1/6},		
		wall_bottom = {-1/6, -0.5, -1/6, 1/6, -1/6, 1/6}, 	
		wall_side = {-1/6, -1/6, -1/6, -0.5, 1/6, 1/6},
		},
})

minetest.register_node("lighting:lamp", {
	description = "Lamp",
	tiles = {"lamp.png", "lamp.png", "lamp.png", "lamp.png", "lamp.png", "lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX,
	groups = {cracky = 2, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
 -- Stairs lights
 
 minetest.register_node("lighting:stairlight", {
  description = "Stair Light (place on stairs)",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0}
  },
  selection_box = {
    type = "fixed",
    fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0}
  },
  walkable = false,
  tiles = {"metal_dark.png"},
  overlay_tiles = {"", "stairlight.png",
    "", "", "stairlight.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 12,
  groups = {cracky = 2, oddly_breakable_by_hand = 3, attached_node = 1},
  node_placement_prediction = "",
  sounds = default.node_sound_glass_defaults(),

  on_place = function(itemstack, placer, pointed_thing)
    local node = minetest.get_node(vector.subtract(pointed_thing.above,
      {x=0, y=1, z=0}))

local stairs_mod = minetest.get_modpath("stairs")
local stairsplus_mod = minetest.get_modpath("moreblocks")
	and minetest.global_exists("stairsplus")
	
    if node and node.name:match("^moreblocks:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^bakedclay:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^allsidedtrees:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end

    if node and node.name:match("^hardenedclay:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^colouredconcrete:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^coloured_glass:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^framed_coloured_glass:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^wool:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^moretrees:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end
    
    if node and node.name:match("^glazedterracotta:stair_")
      and node.param2 < 4 then
      minetest.item_place(itemstack, placer, pointed_thing, node.param2)
    end


    return itemstack
  end,

  on_rotate = function(pos, node, user, mode, new_param2)
    return false
  end,
})

-- path light

lighting.register_variants({
  {name = "lighting:pathlight_d",
    description = "Modern Path Light (dark)",
    tiles = {"metal_dark_32.png^modern_pathlight.png"}},
  {name = "lighting:pathlight_l",
    description = "Modern Path Light (light)",
    tiles = {"metal_light_32.png^modern_pathlight.png"}}
},
{
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {{-1/32, -8/16, -1/32, 1/32, 1/8, 1/32},
      {-1/16, 1/8, -1/16, 1/16, 5/16, 1/16},
      {-1/8, 5/16, -1/8, 1/8, 3/8, 1/8}}
  },
  selection_box = {
    type = "fixed",
    fixed = {{-1/8, -1/2, -1/8, 1/8, 3/8, 1/8}}
  },
  paramtype = "light",
  light_source = 8,
  groups = {cracky = 3, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_metal_defaults(),
})

-- Light Rod

minetest.register_node("lighting:light_rod", {
	description = ("Light Rod"),
	tiles = {
		"light_rod_top.png",
		"light_rod_bottom.png",
		"light_rod_side.png",
		"light_rod_side.png",
		"light_rod_side.png",
		"light_rod_side.png",
	},
	drawtype = "nodebox",
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX,
	sunlight_propagates = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125}, -- Base
			{-0.0625, -0.4375, -0.0625, 0.0625, 0.5, 0.0625}, -- Rod
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- Base
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- Base
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local p0 = pointed_thing.under
		local p1 = pointed_thing.above
		local param2 = 0

		local placer_pos = placer:get_pos()
		if placer_pos then
			local dir = {
				x = p1.x - placer_pos.x,
				y = p1.y - placer_pos.y,
				z = p1.z - placer_pos.z
			}
			param2 = minetest.dir_to_facedir(dir)
		end

		if p0.y - 1 == p1.y then
			param2 = 20
		elseif p0.x - 1 == p1.x then
			param2 = 16
		elseif p0.x + 1 == p1.x then
			param2 = 12
		elseif p0.z - 1 == p1.z then
			param2 = 8
		elseif p0.z + 1 == p1.z then
			param2 = 4
		end

		return minetest.item_place(itemstack, placer, pointed_thing, param2)
	end,
})

