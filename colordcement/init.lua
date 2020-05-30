------------
-- VARIABLE
------------
-- local S = default.get_translator
local coloredcementversion = "1.0"


-- END VARIABLE
----------------

----------------------------
-- Version list chatcommand
----------------------------

minetest.register_chatcommand("coloredcement", {
  privs = {
      interact = true,
  },
  params = "",
  description = "Show Version of coloredcement.",

  func = function(player)
  minetest.chat_send_player(player, "coloredCement Version: ".. coloredcementversion)
end
})

-- END Version list chatcommand
-------------------------------

------------------------
-- Register hard Cement
------------------------
minetest.register_node("colordcement:hard", {
  --description = S("Hard Cement"),
  description = ("Hard Cement"),
  tiles = {"cement_hard.png"},
  paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
  walkable = true,
	sunlight_propagates = false,
	groups = {cracky = 3, stone = 1, ud_param2_colorable = 1},
  drop = "colordcement:hard",
  sounds = default.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "colordcement:hard 3",
  recipe = {
            {"default:sand", "default:gravel", "default:sand"},
            {"default:gravel", "default:gravel", "default:gravel"},
            {"default:sand", "default:gravel", "default:sand"}
  }
})


------------------------
-- Register Sanded Cement
------------------------

minetest.register_node("colordcement:sanded", {
  --description = S("Sanded Cement"),
  description = ("Sanded Cement"),
  tiles = {"cement_sanded.png"},
  paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
  walkable = true,
	sunlight_propagates = false,
	groups = {cracky = 3, stone = 1, ud_param2_colorable = 1},
  drop = "colordcement:sanded",
  sounds = default.node_sound_stone_defaults(),
})


minetest.register_craft({
  output = "colordcement:sanded 3",
  recipe = {
            {"default:sand", "default:sand", "default:sand"},
            {"default:gravel", "default:gravel", "default:gravel"},
            {"default:sand", "default:sand", "default:sand"}
  }
})