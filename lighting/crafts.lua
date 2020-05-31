 -- Crafts

minetest.register_craft({
  output = "lighting:pathlight_d",
  recipe = {
    {"dye:grey", "default:torch", ""},
    {"", "default:steel_ingot", ""},
    {"", "default:steel_ingot", ""}
  }
})

minetest.register_craft({
  output = "lighting:pathlight_l",
  recipe = {
    {"dye:white", "default:torch", ""},
    {"", "default:steel_ingot", ""},
    {"", "default:steel_ingot", ""}
  }
})

minetest.register_craft({
  output = "lighting:stairlight",
  recipe = {
    {"default:steel_ingot", "default:torch", "default:steel_ingot"}
  }
})

minetest.register_craft({
  output = "lighting:glowlight_half_white",
  recipe = {
    {"default:glass", "default:torch", "default:glass"},
    {"default:glass", "default:glass", "default:glass"}
  }
})

minetest.register_craft({
  output = "lighting:glowlight_quarter_white",
  recipe = {
    {"default:glass", "default:torch", "default:glass"},
  }
})

minetest.register_craft({
  output = "lighting:glowlightblock",
  recipe = {
    {"default:glass", "default:glass", "default:glass"},
    {"default:glass", "default:torch", "default:glass"},
    {"default:glass", "default:glass", "default:glass"}
  }
})

minetest.register_craft({
  output = "lighting:glowlight_small_cube_white",
  recipe = {
    {"", "default:glass", ""},
    {"default:glass", "default:torch", "default:glass"},
    {"", "default:glass", ""}
  }
})

minetest.register_craft({
  output = "lighting:barlight_c 4",
  recipe = {
    {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    {"default:copper_ingot", "default:glass", "default:copper_ingot"}
  }
})

minetest.register_craft({
  output = "lighting:barlight_c",
  type = "shapeless",
  recipe = {"lighting:barlight_s"}
})

minetest.register_craft({
  output = "lighting:barlight_s",
  type = "shapeless",
  recipe = {"lighting:barlight_c"}
})

minetest.register_craft({
  output = "lighting:glowlight_modern",
  recipe = {
    {"default:steel_ingot", "default:torch", "default:steel_ingot"},
    {"", "default:glass", ""}
  }
})

minetest.register_craft({
  output = "lighting:modern_walllamp",
  recipe = {
    {"dye:white", "default:glass", ""},
    {"default:glass", "default:torch", "default:steel_ingot"},
    {"", "dye:grey", "default:steel_ingot"}
  }
})

minetest.register_craft({
  output = "lighting:tablelamp_d",
  recipe = {
    {"wool:grey", "default:torch", "wool:grey"},
    {"", "default:steel_ingot", ""},
    {"", "default:steel_ingot", ""}
  }
})

minetest.register_craft({
  output = "lighting:tablelamp_l",
  recipe = {
    {"wool:white", "default:torch", "wool:white"},
    {"", "default:steel_ingot", ""},
    {"", "default:steel_ingot", ""}
  }
})

minetest.register_craft({
  output = "lighting:vintage_lantern_f",
  recipe = {
    {"", "default:steel_ingot", ""},
    {"default:glass", "default:torch", "default:glass"},
    {"default:stick", "default:steel_ingot", "default:stick"}
  }
})

minetest.register_craft({
	output = 'lighting:lantern 4',
	recipe = {
		{'group:stick','default:glass','group:stick'},
		{'default:glass','default:torch','default:glass'},
		{'group:stick','default:glass','group:stick'},
		}
})

minetest.register_craft({
	output = 'lighting:lamp 4',
	recipe = {
	{'default:glass','default:steel_ingot','default:glass'},
	{'default:steel_ingot','default:torch','default:steel_ingot'},
	{'default:glass','default:steel_ingot','default:glass'},
	}
})

minetest.register_craft({
	output = 'lighting:streetpost_d',
	recipe = {
	{'default:steel_ingot'},
	{'default:steel_ingot'},
	{'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'lighting:streetpost_l',
	recipe = {
	{'default:tin_ingot'},
	{'default:steel_ingot'},
	{'default:tin_ingot'},
	}
})

minetest.register_craft({
	output = "lighting:light_rod 4",
	recipe = {
		{"mobs:lava_orb"},
		{"group:stick"},
	},
})
